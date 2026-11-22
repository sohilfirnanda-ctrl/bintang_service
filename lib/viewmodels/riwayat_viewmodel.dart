import 'package:flutter/foundation.dart';

import '../core/network/api_exception.dart';
import '../core/state/view_status.dart';
import '../data/models/booking.dart';
import '../data/repositories/booking_repository.dart';

/// Riwayat booking milik pelanggan yang sedang login.
class RiwayatViewModel extends ChangeNotifier {
  RiwayatViewModel(this._repository);

  final BookingRepository _repository;

  ViewStatus status = ViewStatus.initial;
  List<Booking> bookings = [];
  String? errorMessage;

  Future<void> load({bool refresh = false}) async {
    if (!refresh) status = ViewStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      bookings = await _repository.getMyBookings();
      status = bookings.isEmpty ? ViewStatus.empty : ViewStatus.success;
    } on ApiException catch (error) {
      errorMessage = error.message;
      status = ViewStatus.error;
    } catch (_) {
      errorMessage = 'Terjadi kesalahan tak terduga.';
      status = ViewStatus.error;
    }

    notifyListeners();
  }

  Future<void> refresh() => load(refresh: true);
}
