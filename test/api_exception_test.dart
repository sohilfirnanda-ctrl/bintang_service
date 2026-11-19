import 'package:bintang_service/core/network/api_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

DioException _badResponse(int statusCode, Object? data) {
  final options = RequestOptions(path: '/test');
  return DioException(
    requestOptions: options,
    type: DioExceptionType.badResponse,
    response: Response<dynamic>(
      requestOptions: options,
      statusCode: statusCode,
      data: data,
    ),
  );
}

void main() {
  group('ApiException.fromDio', () {
    test('HTTP 422 menghasilkan pesan error per field', () {
      final error = ApiException.fromDio(
        _badResponse(422, {
          'status': 'error',
          'message': 'Data yang dikirim tidak valid.',
          'errors': {
            'email': ['The email has already been taken.'],
            'phone': ['The phone field format is invalid.'],
          },
        }),
      );

      expect(error.isValidation, isTrue);
      expect(error.statusCode, 422);
      expect(error.message, 'Data yang dikirim tidak valid.');
      expect(error.firstErrors['email'], 'The email has already been taken.');
      expect(error.firstErrors['phone'], 'The phone field format is invalid.');
    });

    test('HTTP 401 ditandai sebagai unauthorized', () {
      final error = ApiException.fromDio(
        _badResponse(401, {
          'status': 'error',
          'message': 'Email atau password salah.',
        }),
      );

      expect(error.isUnauthorized, isTrue);
      expect(error.message, 'Email atau password salah.');
    });

    test('HTTP 500 menjadi error server', () {
      final error = ApiException.fromDio(_badResponse(500, '<html>error</html>'));

      expect(error.type, ApiErrorType.server);
      expect(error.message, contains('500'));
    });

    test('backend mati (connection error) menjadi error jaringan', () {
      final error = ApiException.fromDio(
        DioException(
          requestOptions: RequestOptions(path: '/services'),
          type: DioExceptionType.connectionError,
        ),
      );

      expect(error.type, ApiErrorType.network);
      expect(error.isConnectionProblem, isTrue);
    });

    test('timeout menjadi error timeout', () {
      final error = ApiException.fromDio(
        DioException(
          requestOptions: RequestOptions(path: '/services'),
          type: DioExceptionType.receiveTimeout,
        ),
      );

      expect(error.type, ApiErrorType.timeout);
    });
  });
}
