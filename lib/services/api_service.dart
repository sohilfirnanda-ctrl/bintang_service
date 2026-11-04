
import 'dart:convert';

import 'package:http/http.dart' as http;

// ============================================================
// DATA LAYANAN
// ============================================================

class ServiceItem {
  final int databaseId;
  final String nama;
  final String kategori;
  final String deskripsi;
  final int harga;

  const ServiceItem({
    required this.databaseId,
    required this.nama,
    required this.kategori,
    required this.deskripsi,
    required this.harga,
  });

  // Membaca harga database tanpa menambah angka nol.
  static int bacaHarga(dynamic value) {
    if (value == null) return 0;

    if (value is int) return value;

    if (value is num) return value.round();

    final teks = value
        .toString()
        .trim()
        .replaceAll('Rp', '')
        .replaceAll(' ', '');

    if (teks.isEmpty) return 0;

    // Contoh: 20000.00 menjadi 20000.
    if (RegExp(r'^\d+\.\d{1,2}$').hasMatch(teks)) {
      return double.tryParse(teks)?.round() ?? 0;
    }

    // Contoh: Rp20.000 menjadi 20000.
    final angka = teks.replaceAll(RegExp(r'[^0-9]'), '');

    return int.tryParse(angka) ?? 0;
  }

  static String bacaTeks(
    Map<String, dynamic> json,
    List<String> keys, {
    String fallback = '',
  }) {
    for (final key in keys) {
      final value = json[key];

      if (value != null && value.toString().trim().isNotEmpty) {
        return value.toString().trim();
      }
    }

    return fallback;
  }

  factory ServiceItem.fromJson(Map<String, dynamic> json) {
    return ServiceItem(
      databaseId: bacaHarga(
        json['id'] ?? json['service_id'] ?? json['id_layanan'],
      ),
      nama: bacaTeks(
        json,
        ['service_name', 'nama_layanan', 'name', 'nama'],
        fallback: 'Layanan',
      ),
      kategori: bacaTeks(
        json,
        ['category', 'kategori', 'nama_kategori'],
        fallback: 'Lainnya',
      ),
      deskripsi: bacaTeks(
        json,
        ['description', 'deskripsi'],
      ),
      harga: bacaHarga(
        json['price'] ??
            json['harga'] ??
            json['service_price'] ??
            json['biaya'] ??
            json['tarif'],
      ),
    );
  }
}

// ============================================================
// API SERVICE
// ============================================================

class ApiService {
  static const String baseUrl =
      'http://localhost/bintang_service_backend';

  final http.Client client;

  ApiService({http.Client? client})
      : client = client ?? http.Client();

  // ==========================================================
  // MENGAMBIL KATALOG LAYANAN
  // ==========================================================

  Future<List<ServiceItem>> getServices() async {
    final response = await client
        .get(Uri.parse('$baseUrl/services.php'))
        .timeout(const Duration(seconds: 20));

    if (response.statusCode != 200) {
      throw Exception(
        'Gagal mengambil katalog. Kode: ${response.statusCode}',
      );
    }

    final decoded = jsonDecode(response.body);

    dynamic data = decoded;

    if (decoded is Map<String, dynamic>) {
      if (decoded['status'] == 'error' ||
          decoded['success'] == false) {
        throw Exception(
          decoded['message'] ?? 'Gagal mengambil katalog layanan',
        );
      }

      data = decoded['data'] ?? decoded['services'] ?? [];
    }

    if (data is! List) {
      throw Exception(
        'Format data katalog dari server tidak sesuai.',
      );
    }

    final services = data
        .map(
          (item) => ServiceItem.fromJson(
            Map<String, dynamic>.from(item),
          ),
        )
        .toList();

    final ids = services.map((item) => item.databaseId).toList();
    final uniqueIds = ids.toSet();

    if (ids.any((id) => id <= 0)) {
      throw Exception(
        'Ada layanan yang tidak memiliki ID database valid.',
      );
    }

    if (uniqueIds.length != ids.length) {
      throw Exception(
        'ID layanan database duplikat.',
      );
    }

    return services;
  }

  // ==========================================================
  // MEMBUAT BOOKING
  // ==========================================================

  Future<Map<String, dynamic>> createBooking({
    required String name,
    required String phone,
    required String bookingDate,
    required String bookingTime,
    required String motorcycleType,
    required String motorcycleNumber,
    required List<int> serviceIds,
  }) async {
    final response = await client
        .post(
          Uri.parse('$baseUrl/bookings.php'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
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
        )
        .timeout(const Duration(seconds: 20));

    final decoded = jsonDecode(response.body);

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw Exception(
        decoded is Map
            ? decoded['message'] ?? 'Booking gagal disimpan'
            : 'Booking gagal disimpan',
      );
    }

    if (decoded is Map<String, dynamic> &&
        (decoded['success'] == false ||
            decoded['status'] == 'error')) {
      throw Exception(
        decoded['message'] ?? 'Booking gagal disimpan',
      );
    }

    if (decoded is Map<String, dynamic>) {
      return decoded;
    }

    return {'success': true};
  }

  // ==========================================================
  // RIWAYAT BOOKING
  // ==========================================================

  Future<List<Map<String, dynamic>>> getBookingHistory({
    required String phone,
  }) async {
    final uri = Uri.parse(
      '$baseUrl/booking_history.php',
    ).replace(
      queryParameters: {'phone': phone},
    );

    final response = await client
        .get(uri)
        .timeout(const Duration(seconds: 20));

    if (response.statusCode != 200) {
      throw Exception(
        'Gagal mengambil riwayat booking.',
      );
    }

    final decoded = jsonDecode(response.body);

    dynamic data = decoded;

    if (decoded is Map<String, dynamic>) {
      if (decoded['success'] == false ||
          decoded['status'] == 'error') {
        throw Exception(
          decoded['message'] ??
              'Gagal mengambil riwayat booking',
        );
      }

      data = decoded['data'] ?? [];
    }

    if (data is! List) {
      throw Exception(
        'Format riwayat booking tidak sesuai.',
      );
    }

    return data
        .map(
          (item) => Map<String, dynamic>.from(item),
        )
        .toList();
  }
}
