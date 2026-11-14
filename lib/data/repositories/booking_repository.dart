import '../models/booking.dart';
import '../services/booking_service.dart';

class BookingRepository {
  BookingRepository(this._service);

  final BookingService _service;

  Future<Booking> createBooking({
    required String motorType,
    required String plateNumber,
    required String bookingDate,
    required String bookingTime,
    required String complaint,
    required List<int> serviceIds,
  }) async {
    final data = await _service.createBooking({
      'motor_type': motorType.trim(),
      'plate_number': plateNumber.trim(),
      'booking_date': bookingDate,
      'booking_time': bookingTime,
      if (complaint.trim().isNotEmpty) 'complaint': complaint.trim(),
      'service_ids': serviceIds,
    });
    return Booking.fromJson(data);
  }

  Future<List<Booking>> getMyBookings() async {
    final rows = await _service.fetchBookings();
    return rows.map(Booking.fromJson).toList();
  }
}
