import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/state/view_status.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/booking.dart';
import '../../viewmodels/riwayat_viewmodel.dart';
import '../widgets/state_views.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RiwayatViewModel>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RiwayatViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Booking')),
      body: RefreshIndicator(
        color: warnaEmas,
        onRefresh: viewModel.refresh,
        child: _buildContent(viewModel),
      ),
    );
  }

  Widget _buildContent(RiwayatViewModel viewModel) {
    switch (viewModel.status) {
      case ViewStatus.initial:
      case ViewStatus.loading:
        return const ScrollableFill(child: LoadingView());
      case ViewStatus.error:
        return ScrollableFill(
          child: ErrorView(
            message: viewModel.errorMessage ?? 'Terjadi kesalahan.',
            onRetry: viewModel.load,
          ),
        );
      case ViewStatus.empty:
        return const ScrollableFill(
          child: EmptyView(message: 'Belum ada riwayat booking.'),
        );
      case ViewStatus.success:
        return ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          itemCount: viewModel.bookings.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) =>
              _RiwayatCard(booking: viewModel.bookings[index]),
        );
    }
  }
}

class _RiwayatCard extends StatelessWidget {
  const _RiwayatCard({required this.booking});

  final Booking booking;

  Color get _statusColor {
    switch (booking.status) {
      case 'completed':
        return warnaHijau;
      case 'cancelled':
        return warnaMerah;
      default:
        return warnaEmas;
    }
  }

  @override
  Widget build(BuildContext context) {
    final services = booking.details.map((d) => d.serviceName).join(', ');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: warnaKartu,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  booking.bookingCode,
                  style: const TextStyle(
                    color: warnaEmas,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  booking.statusLabel,
                  style: TextStyle(color: _statusColor, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('${booking.bookingDate}  ${booking.bookingTime}'),
          const SizedBox(height: 4),
          Text(
            '${booking.motorType} • ${booking.plateNumber}',
            style: const TextStyle(color: warnaAbu),
          ),
          if (services.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(services, style: const TextStyle(color: warnaAbu)),
          ],
          const SizedBox(height: 8),
          Text(
            formatRupiah(booking.totalPrice),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
