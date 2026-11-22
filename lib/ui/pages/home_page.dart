import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/state/view_status.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/service_item.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/layanan_list_viewmodel.dart';
import '../app_routes.dart';
import '../widgets/state_views.dart';

/// Beranda: daftar layanan dari database (real API) dengan
/// loading, error + Coba Lagi, kosong, sukses, refresh, dan filter.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<LayananListViewModel>();
    _searchController.text = viewModel.query;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (viewModel.status == ViewStatus.initial) viewModel.load();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      context.read<LayananListViewModel>().search(value);
    });
  }

  void _clearSearch() {
    _debounce?.cancel();
    _searchController.clear();
    context.read<LayananListViewModel>().search('');
  }

  Future<void> _confirmLogout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: warnaKartu,
        title: const Text('Keluar'),
        content: const Text('Yakin ingin keluar dari akun ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Keluar', style: TextStyle(color: warnaMerah)),
          ),
        ],
      ),
    );

    if (confirm != true || !mounted) return;

    final auth = context.read<AuthViewModel>();
    final layanan = context.read<LayananListViewModel>();
    await auth.logout();
    layanan.reset();

    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();
    final viewModel = context.watch<LayananListViewModel>();
    final name = auth.customer?.name ?? 'Pelanggan';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BINTANG SERVICE',
          style: TextStyle(color: warnaEmas, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Riwayat booking',
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.riwayat),
          ),
          IconButton(
            key: const Key('logout_button'),
            tooltip: 'Keluar',
            icon: const Icon(Icons.logout),
            onPressed: auth.isSubmitting ? null : _confirmLogout,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Halo, $name', style: const TextStyle(color: warnaAbu)),
                const SizedBox(height: 6),
                const Text(
                  'Pilih Layanan Servis',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),
                TextField(
                  key: const Key('search_field'),
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  onSubmitted: (value) {
                    _debounce?.cancel();
                    viewModel.search(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari layanan, contoh: oli',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: _clearSearch,
                          ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              color: warnaEmas,
              onRefresh: viewModel.refresh,
              child: _buildContent(viewModel),
            ),
          ),
        ],
      ),
      bottomNavigationBar: viewModel.selectedCount == 0
          ? null
          : _SelectionBar(
              count: viewModel.selectedCount,
              total: viewModel.selectedTotal,
              onNext: () => Navigator.pushNamed(context, AppRoutes.bookingForm),
            ),
    );
  }

  Widget _buildContent(LayananListViewModel viewModel) {
    switch (viewModel.status) {
      case ViewStatus.initial:
      case ViewStatus.loading:
        return const ScrollableFill(
          child: LoadingView(message: 'Memuat layanan...'),
        );
      case ViewStatus.error:
        return ScrollableFill(
          child: ErrorView(
            message: viewModel.errorMessage ?? 'Terjadi kesalahan.',
            onRetry: viewModel.retry,
          ),
        );
      case ViewStatus.empty:
        return ScrollableFill(
          child: EmptyView(
            icon: Icons.search_off,
            message: viewModel.query.isEmpty
                ? 'Belum ada layanan yang tersedia.'
                : 'Layanan "${viewModel.query}" tidak ditemukan.',
          ),
        );
      case ViewStatus.success:
        return ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
          itemCount: viewModel.services.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final service = viewModel.services[index];
            return _ServiceCard(
              service: service,
              selected: viewModel.isSelected(service.id),
              onToggle: () => viewModel.toggle(service),
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.layananDetail,
                arguments: service.id,
              ),
            );
          },
        );
    }
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({
    required this.service,
    required this.selected,
    required this.onToggle,
    required this.onTap,
  });

  final ServiceItem service;
  final bool selected;
  final VoidCallback onToggle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: warnaKartu,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: selected ? warnaEmas : Colors.white12),
          ),
          child: Row(
            children: [
              const Icon(Icons.build_circle_outlined, color: warnaEmas, size: 36),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      service.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: warnaAbu, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${formatRupiah(service.price)} • ${service.durationMinutes} menit',
                      style: const TextStyle(
                        color: warnaEmas,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Checkbox(
                value: selected,
                activeColor: warnaEmas,
                checkColor: Colors.black,
                onChanged: (_) => onToggle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectionBar extends StatelessWidget {
  const _SelectionBar({
    required this.count,
    required this.total,
    required this.onNext,
  });

  final int count;
  final int total;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
        decoration: const BoxDecoration(
          color: warnaKartu,
          border: Border(top: BorderSide(color: Colors.white12)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$count layanan dipilih',
                    style: const TextStyle(color: warnaAbu),
                  ),
                  Text(
                    formatRupiah(total),
                    style: const TextStyle(
                      color: warnaEmas,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              key: const Key('next_booking_button'),
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: warnaEmas,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              ),
              child: const Text(
                'LANJUT BOOKING',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
