import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../../viewmodels/booking_viewmodel.dart';
import '../../viewmodels/layanan_list_viewmodel.dart';
import '../app_routes.dart';
import '../widgets/error_banner.dart';
import '../widgets/tombol_utama.dart';

/// Form booking. Validasi dilakukan Laravel (StoreBookingRequest);
/// error 422 ditampilkan di bawah field masing-masing.
class BookingFormPage extends StatefulWidget {
  const BookingFormPage({super.key});

  @override
  State<BookingFormPage> createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  final _motorController = TextEditingController();
  final _plateController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _complaintController = TextEditingController();

  @override
  void dispose() {
    _motorController.dispose();
    _plateController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _complaintController.dispose();
    super.dispose();
  }

  String _twoDigits(int value) => value.toString().padLeft(2, '0');

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(const Duration(days: 30)),
      lastDate: now.add(const Duration(days: 365)),
    );
    if (!mounted) return;
    if (picked == null) return;

    _dateController.text =
        '${picked.year}-${_twoDigits(picked.month)}-${_twoDigits(picked.day)}';
    context.read<BookingViewModel>().clearFieldError('booking_date');
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    if (!mounted) return;
    if (picked == null) return;

    _timeController.text =
        '${_twoDigits(picked.hour)}:${_twoDigits(picked.minute)}';
    context.read<BookingViewModel>().clearFieldError('booking_time');
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    final booking = context.read<BookingViewModel>();
    final layanan = context.read<LayananListViewModel>();

    final success = await booking.submit(
      motorType: _motorController.text,
      plateNumber: _plateController.text,
      bookingDate: _dateController.text,
      bookingTime: _timeController.text,
      complaint: _complaintController.text,
      serviceIds: layanan.selectedServices.map((s) => s.id).toList(),
    );

    if (!mounted) return;
    if (!success) return;

    final created = booking.createdBooking;
    layanan.clearSelection();
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.bookingSuccess,
      ModalRoute.withName(AppRoutes.home),
      arguments: created,
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<BookingViewModel>();
    final layanan = context.watch<LayananListViewModel>();
    final selected = layanan.selectedServices;

    return Scaffold(
      appBar: AppBar(title: const Text('Form Booking Servis')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Layanan dipilih',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: warnaKartu,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: viewModel.servicesError != null
                      ? warnaMerah
                      : Colors.white12,
                ),
              ),
              child: selected.isEmpty
                  ? const Text(
                      'Belum ada layanan dipilih.',
                      style: TextStyle(color: warnaAbu),
                    )
                  : Column(
                      children: [
                        for (final service in selected)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Expanded(child: Text(service.name)),
                                Text(formatRupiah(service.price)),
                              ],
                            ),
                          ),
                        const Divider(color: Colors.white24),
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Total',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              formatRupiah(layanan.selectedTotal),
                              style: const TextStyle(
                                color: warnaEmas,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
            if (viewModel.servicesError != null)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 12),
                child: Text(
                  viewModel.servicesError!,
                  style: const TextStyle(color: warnaMerah, fontSize: 12),
                ),
              ),
            const SizedBox(height: 22),
            const Text(
              'Data kendaraan & jadwal',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              key: const Key('booking_motor_type'),
              controller: _motorController,
              onChanged: (_) => viewModel.clearFieldError('motor_type'),
              decoration: InputDecoration(
                labelText: 'Jenis motor (contoh: Honda Vario 125)',
                prefixIcon: const Icon(Icons.two_wheeler),
                errorText: viewModel.fieldError('motor_type'),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              key: const Key('booking_plate_number'),
              controller: _plateController,
              textCapitalization: TextCapitalization.characters,
              onChanged: (_) => viewModel.clearFieldError('plate_number'),
              decoration: InputDecoration(
                labelText: 'Nomor polisi (contoh: BL 1234 AB)',
                prefixIcon: const Icon(Icons.pin_outlined),
                errorText: viewModel.fieldError('plate_number'),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              key: const Key('booking_date'),
              controller: _dateController,
              readOnly: true,
              onTap: _pickDate,
              decoration: InputDecoration(
                labelText: 'Tanggal servis',
                prefixIcon: const Icon(Icons.calendar_today),
                errorText: viewModel.fieldError('booking_date'),
                errorMaxLines: 2,
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              key: const Key('booking_time'),
              controller: _timeController,
              readOnly: true,
              onTap: _pickTime,
              decoration: InputDecoration(
                labelText: 'Jam servis',
                prefixIcon: const Icon(Icons.access_time),
                errorText: viewModel.fieldError('booking_time'),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              key: const Key('booking_complaint'),
              controller: _complaintController,
              maxLines: 3,
              onChanged: (_) => viewModel.clearFieldError('complaint'),
              decoration: InputDecoration(
                labelText: 'Keluhan (opsional)',
                alignLabelWithHint: true,
                errorText: viewModel.fieldError('complaint'),
              ),
            ),
            const SizedBox(height: 20),
            if (viewModel.errorMessage != null) ...[
              ErrorBanner(message: viewModel.errorMessage!),
              const SizedBox(height: 16),
            ],
            TombolUtama(
              teks: 'KIRIM BOOKING',
              isLoading: viewModel.isSubmitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
