
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'http://localhost/bintang_service_backend';

  // Client dapat diganti dengan MockClient saat pengujian.
  static http.Client client = http.Client();

  // Mengambil daftar layanan dari database.
  static Future<List<dynamic>> getServices() async {
    final response = await client.get(
      Uri.parse('$baseUrl/services.php'),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      if (result['status'] == 'success') {
        return result['data'];
      }
    }

    throw Exception('Gagal mengambil daftar layanan');
  }

  // Mengirim data pemesanan ke backend.
  static Future<Map<String, dynamic>> createBooking({
    required String name,
    required String phone,
    required String bookingDate,
    required String bookingTime,
    required String motorcycleType,
    required String motorcycleNumber,
    required List<int> serviceIds,
  }) async {
    final response = await client.post(
      Uri.parse('$baseUrl/bookings.php'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'phone': phone,
        'booking_date': bookingDate,
        'booking_time': bookingTime,
        'motorcycle_type': motorcycleType,
        'motorcycle_number': motorcycleNumber,
        'service_ids': serviceIds,
      }),
    );

    final result = jsonDecode(response.body);

    if (response.statusCode == 200 &&
        result['status'] == 'success') {
      return result['data'];
    }

    throw Exception(result['message'] ?? 'Booking gagal');
  }

  // Mengambil riwayat pemesanan.
  static Future<List<dynamic>> getBookingHistory() async {
    final response = await client.get(
      Uri.parse('$baseUrl/booking_history.php'),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      if (result['status'] == 'success') {
        return result['data'];
      }
    }

    throw Exception('Gagal mengambil riwayat booking');
  }
}
