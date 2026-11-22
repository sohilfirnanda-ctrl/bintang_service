import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../config/api_config.dart';
import '../storage/token_storage.dart';
import 'api_exception.dart';

/// Lapisan HTTP satu-satunya di aplikasi (Dio).
/// - Menambahkan header Accept JSON dan token Bearer otomatis.
/// - Mengubah DioException menjadi [ApiException].
/// - Memanggil [onUnauthorized] ketika token ditolak server (401).
class ApiClient {
  ApiClient({
    required TokenStorage tokenStorage,
    Dio? client,
    this.onUnauthorized,
  })  : _tokenStorage = tokenStorage,
        dio = client ??
            Dio(
              BaseOptions(
                baseUrl: ApiConfig.baseUrl,
                connectTimeout: ApiConfig.connectTimeout,
                receiveTimeout: ApiConfig.receiveTimeout,
                // Wajib agar Laravel membalas JSON (bukan redirect HTML).
                headers: const {'Accept': 'application/json'},
              ),
            ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _tokenStorage.readToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          final path = error.requestOptions.path;
          if (error.response?.statusCode == 401 && !_authPaths.contains(path)) {
            await _tokenStorage.deleteToken();
            onUnauthorized?.call();
          }
          handler.next(error);
        },
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (object) => debugPrint(object.toString()),
        ),
      );
    }
  }

  /// Endpoint auth menangani 401 sendiri (misalnya password salah),
  /// jadi tidak memicu logout paksa.
  static const Set<String> _authPaths = {'/login', '/register', '/me', '/logout'};

  final TokenStorage _tokenStorage;
  final Dio dio;

  /// Diisi di main.dart: arahkan pengguna ke halaman login.
  void Function()? onUnauthorized;

  Future<dynamic> get(String path, {Map<String, dynamic>? query}) {
    return _send(() => dio.get<dynamic>(path, queryParameters: query));
  }

  Future<dynamic> post(String path, {Object? data}) {
    return _send(() => dio.post<dynamic>(path, data: data));
  }

  Future<dynamic> _send(Future<Response<dynamic>> Function() request) async {
    try {
      final response = await request();
      return response.data;
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }

  /// Mengambil bagian "data" berbentuk objek dari format
  /// { "status": ..., "message": ..., "data": {...} }.
  static Map<String, dynamic> unwrapMap(dynamic body) {
    if (body is Map && body['data'] is Map) {
      return Map<String, dynamic>.from(body['data'] as Map);
    }
    throw const ApiException('Format respons server tidak sesuai.');
  }

  /// Mengambil bagian "data" berbentuk daftar.
  static List<Map<String, dynamic>> unwrapList(dynamic body) {
    if (body is Map && body['data'] is List) {
      return (body['data'] as List)
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }
    throw const ApiException('Format respons server tidak sesuai.');
  }
}
