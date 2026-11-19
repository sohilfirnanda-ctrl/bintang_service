import '../../core/network/api_client.dart';

class BookingService {
  BookingService(this._client);

  final ApiClient _client;

  /// POST /api/bookings (wajib token)
  Future<Map<String, dynamic>> createBooking(Map<String, dynamic> payload) async {
    final body = await _client.post('/bookings', data: payload);
    return ApiClient.unwrapMap(body);
  }

  /// GET /api/bookings (riwayat milik pelanggan yang login)
  Future<List<Map<String, dynamic>>> fetchBookings() async {
    final body = await _client.get('/bookings', query: {'per_page': 50});
    return ApiClient.unwrapList(body);
  }
}
