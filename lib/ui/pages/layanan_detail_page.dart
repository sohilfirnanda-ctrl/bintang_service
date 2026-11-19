import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/state/view_status.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/service_item.dart';
import '../../viewmodels/layanan_detail_viewmodel.dart';
import '../../viewmodels/layanan_list_viewmodel.dart';
import '../widgets/state_views.dart';
import '../widgets/tombol_utama.dart';

/// Detail layanan diambil ulang dari GET /api/services/{id}.
class LayananDetailPage extends StatefulWidget {
  const LayananDetailPage({super.key, required this.serviceId});

  final int serviceId;

  @override
  State<LayananDetailPage> createState() => _LayananDetailPageState();
}

class _LayananDetailPageState extends State<LayananDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LayananDetailViewModel>().load(widget.serviceId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LayananDetailViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Layanan')),
      body: _buildBody(viewModel),
    );
  }

  Widget _buildBody(LayananDetailViewModel viewModel) {
    switch (viewModel.status) {
      case ViewStatus.initial:
      case ViewStatus.loading:
        return const LoadingView(message: 'Memuat detail layanan...');
      case ViewStatus.error:
        return ErrorView(
          message: viewModel.errorMessage ?? 'Terjadi kesalahan.',
          onRetry: viewModel.retry,
        );
      case ViewStatus.empty:
      case ViewStatus.success:
        final service = viewModel.service;
        if (service == null) {
          return const EmptyView(message: 'Layanan tidak ditemukan.');
        }
        return _DetailContent(service: service);
    }
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.service});

  final ServiceItem service;

  @override
  Widget build(BuildContext context) {
    final list = context.watch<LayananListViewModel>();
    final selected = list.isSelected(service.id);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Icon(Icons.build_circle_outlined, color: warnaEmas, size: 90),
          ),
          const SizedBox(height: 20),
          Text(
            service.name,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            formatRupiah(service.price),
            style: const TextStyle(
              color: warnaEmas,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _InfoRow(
            icon: Icons.timer_outlined,
            label: 'Estimasi pengerjaan',
            value: '${service.durationMinutes} menit',
          ),
          const SizedBox(height: 10),
          _InfoRow(
            icon: Icons.check_circle_outline,
            label: 'Status',
            value: service.isActive ? 'Tersedia' : 'Tidak tersedia',
          ),
          const SizedBox(height: 20),
          const Text(
            'Deskripsi',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            service.description.isEmpty ? '-' : service.description,
            style: const TextStyle(color: warnaAbu, height: 1.6),
          ),
          const SizedBox(height: 30),
          TombolUtama(
            teks: selected ? 'HAPUS DARI PILIHAN' : 'PILIH LAYANAN INI',
            onPressed: () {
              list.toggle(service);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: warnaKartu,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          Icon(icon, color: warnaEmas),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: const TextStyle(color: warnaAbu)),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
