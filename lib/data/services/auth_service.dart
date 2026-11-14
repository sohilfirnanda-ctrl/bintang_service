import '../../core/network/api_client.dart';

/// Service = pemanggilan endpoint mentah (tanpa logika aplikasi).
class AuthService {
  AuthService(this._client);

  final ApiClient _client;

  /// POST /api/login -> { customer, token, token_type }
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final body = await _client.post(
      '/login',
      data: {'email': email, 'password': password},
    );
    return ApiClient.unwrapMap(body);
  }

  /// POST /api/register -> { customer, token, token_type }
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    final body = await _client.post(
      '/register',
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );
    return ApiClient.unwrapMap(body);
  }

  /// GET /api/me -> data customer
  Future<Map<String, dynamic>> me() async {
    final body = await _client.get('/me');
    return ApiClient.unwrapMap(body);
  }

  /// POST /api/logout
  Future<void> logout() async {
    await _client.post('/logout');
  }
}
