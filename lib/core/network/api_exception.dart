import 'package:dio/dio.dart';

enum ApiErrorType {
  network,
  timeout,
  unauthorized,
  validation,
  notFound,
  server,
  other,
}

/// Satu jenis error untuk seluruh aplikasi.
/// Widget tidak perlu tahu tentang Dio, cukup membaca [message]
/// dan [fieldErrors] (untuk error validasi HTTP 422).
class ApiException implements Exception {
  const ApiException(
    this.message, {
    this.type = ApiErrorType.other,
    this.statusCode,
    this.fieldErrors = const {},
  });

  final String message;
  final ApiErrorType type;
  final int? statusCode;

  /// Contoh isi: {'email': ['The email has already been taken.']}
  final Map<String, List<String>> fieldErrors;

  bool get isValidation => type == ApiErrorType.validation;
  bool get isUnauthorized => type == ApiErrorType.unauthorized;
  bool get isConnectionProblem =>
      type == ApiErrorType.network || type == ApiErrorType.timeout;

  /// Pesan pertama untuk setiap field, siap ditampilkan di TextField.
  Map<String, String> get firstErrors => {
        for (final entry in fieldErrors.entries)
          if (entry.value.isNotEmpty) entry.key: entry.value.first,
      };

  factory ApiException.fromDio(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ApiException(
          'Server tidak merespons. Periksa koneksi lalu coba lagi.',
          type: ApiErrorType.timeout,
        );
      case DioExceptionType.connectionError:
        return const ApiException(
          'Tidak dapat terhubung ke server. Pastikan backend sudah berjalan.',
          type: ApiErrorType.network,
        );
      default:
        break;
    }

    final response = error.response;
    if (response == null) {
      return const ApiException(
        'Tidak dapat terhubung ke server. Pastikan backend sudah berjalan.',
        type: ApiErrorType.network,
      );
    }

    final code = response.statusCode;
    final body = response.data;
    String? serverMessage;
    final errors = <String, List<String>>{};

    if (body is Map) {
      final message = body['message'];
      if (message is String && message.isNotEmpty) {
        serverMessage = message;
      }

      final rawErrors = body['errors'];
      if (rawErrors is Map) {
        rawErrors.forEach((key, value) {
          if (value is List) {
            errors[key.toString()] =
                value.map((item) => item.toString()).toList();
          } else if (value != null) {
            errors[key.toString()] = [value.toString()];
          }
        });
      }
    }

    if (code == 401) {
      return ApiException(
        serverMessage ?? 'Sesi berakhir, silakan login kembali.',
        type: ApiErrorType.unauthorized,
        statusCode: code,
      );
    }

    if (code == 422) {
      return ApiException(
        serverMessage ?? 'Data yang dikirim tidak valid.',
        type: ApiErrorType.validation,
        statusCode: code,
        fieldErrors: errors,
      );
    }

    if (code == 404) {
      return ApiException(
        serverMessage ?? 'Data tidak ditemukan.',
        type: ApiErrorType.notFound,
        statusCode: code,
      );
    }

    if (code != null && code >= 500) {
      return ApiException(
        'Server sedang bermasalah (kode $code). Coba lagi nanti.',
        type: ApiErrorType.server,
        statusCode: code,
      );
    }

    return ApiException(
      serverMessage ?? 'Terjadi kesalahan (kode $code).',
      statusCode: code,
    );
  }

  @override
  String toString() => message;
}
