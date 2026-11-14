import 'package:flutter/foundation.dart';

import '../core/network/api_exception.dart';
import '../data/models/booking.dart';
import '../data/repositories/booking_repository.dart';

/// Form create booking: kirim ke POST /api/bookings dan
/// tampilkan error validasi 422 per field.
class BookingViewModel extends ChangeNotifier {
  BookingViewModel(this._repository);

  final BookingRepository _repository;

  bool isSubmitting = false;
  String? errorMessage;
  Map<String, String> fieldErrors = {};
  Booking? createdBooking;

  String? fieldError(String field) => fieldErrors[field];

  /// Laravel bisa mengirim key "service_ids" atau "service_ids.0".
  String? get servicesError {
    for (final entry in fieldErrors.entries) {
      if (entry.key.startsWith('service_ids')) return entry.value;
    }
    return null;
  }

  void clearFieldError(String field) {
    if (fieldErrors.remove(field) != null) notifyListeners();
  }

  Future<bool> submit({
    required String motorType,
    required String plateNumber,
    required String bookingDate,
    required String bookingTime,
    required String complaint,
    required List<int> serviceIds,
  }) async {
    isSubmitting = true;
    errorMessage = null;
    fieldErrors = {};
    notifyListeners();

    try {
      createdBooking = await _repository.createBooking(
        motorType: motorType,
        plateNumber: plateNumber,
        bookingDate: bookingDate,
        bookingTime: bookingTime,
        complaint: complaint,
        serviceIds: serviceIds,
      );
      return true;
    } on ApiException catch (error) {
      errorMessage = error.message;
      fieldErrors = error.firstErrors;
      return false;
    } catch (_) {
      errorMessage = 'Terjadi kesalahan tak terduga. Coba lagi.';
      return false;
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }
}
