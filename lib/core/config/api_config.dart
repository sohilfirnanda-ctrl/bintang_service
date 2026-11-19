import 'package:flutter/foundation.dart';

/// Konfigurasi alamat backend Laravel (bintang_service_api).
///
/// Alamat bisa diganti tanpa mengubah kode:
/// flutter run --dart-define=API_BASE_URL=http://192.168.1.5:8000/api
class ApiConfig {
  ApiConfig._();

  static const String _fromEnvironment = String.fromEnvironment('API_BASE_URL');

  static String get baseUrl {
    if (_fromEnvironment.isNotEmpty) return _fromEnvironment;

    if (kIsWeb) return 'http://127.0.0.1:8000/api';

    // Emulator Android tidak bisa memakai "localhost" milik laptop.
    // 10.0.2.2 adalah alamat khusus emulator untuk localhost laptop.
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:8000/api';
    }

    return 'http://127.0.0.1:8000/api';
  }

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
