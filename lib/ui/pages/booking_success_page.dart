import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../data/models/booking.dart';
import '../app_routes.dart';
import '../widgets/tombol_utama.dart';

class BookingSuccessPage extends StatelessWidget {
  const BookingSuccessPage({super.key, required this.booking});

  final Booking? booking;

  @override
  Widget build(BuildContext context) {
    final data = booking;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Icon(Icons.check_circle, color: warnaHijau, size: 90),
              const SizedBox(height: 16),
              const Text(
                'Booking Berhasil!',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Data booking sudah tersimpan di server.',
                style: TextStyle(color: warnaAbu),
              ),
              const SizedBox(height: 24),
              if (data != null) _BookingSummary(booking: data),
              const SizedBox(height: 28),
              TombolUtama(
                teks: 'KEMBALI KE BERANDA',
                onPressed: () => Navigator.popUntil(
                  context,
                  ModalRoute.withName(AppRoutes.home),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  foregroundColor: warnaEmas,
                  side: const BorderSide(color: warnaEmas),
                ),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, AppRoutes.riwayat),
                child: const Text('LIHAT RIWAYAT BOOKING'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BookingSummary extends StatelessWidget {
  const _BookingSummary({required this.booking});

  final Booking booking;

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: const TextStyle(color: warnaAbu)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: warnaKartu,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            booking.bookingCode,
            style: const TextStyle(
              color: warnaEmas,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          _row('Status', booking.statusLabel),
          _row('Jadwal', '${booking.bookingDate}  ${booking.bookingTime}'),
          _row('Motor', booking.motorType),
          _row('No. polisi', booking.plateNumber),
          if (booking.complaint != null) _row('Keluhan', booking.complaint!),
          const Divider(color: Colors.white24, height: 24),
          for (final detail in booking.details)
            _row(detail.serviceName, formatRupiah(detail.price)),
          const Divider(color: Colors.white24, height: 24),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Total',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                formatRupiah(booking.totalPrice),
                style: const TextStyle(
                  color: warnaEmas,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
