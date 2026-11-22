import '../../core/network/api_exception.dart';
import '../../core/storage/token_storage.dart';
import '../models/customer.dart';
import '../services/auth_service.dart';

/// Repository = logika data: memanggil service, mengubah JSON
/// menjadi model, dan mengelola token di SecureStorage.
class AuthRepository {
  AuthRepository({
    required AuthService service,
    required TokenStorage tokenStorage,
  })  : _service = service,
        _tokenStorage = tokenStorage;

  final AuthService _service;
  final TokenStorage _tokenStorage;

  Future<Customer> login({
    required String email,
    required String password,
  }) async {
    final data = await _service.login(email: email, password: password);
    return _saveSession(data);
  }

  Future<Customer> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    final data = await _service.register(
      name: name,
      email: email,
      phone: phone,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    return _saveSession(data);
  }

  /// Dipakai Splash untuk auto-login.
  /// Mengembalikan null bila belum login atau token sudah tidak berlaku.
  Future<Customer?> restoreSession() async {
    if (!await _tokenStorage.hasToken()) return null;

    try {
      final data = await _service.me();
      return Customer.fromJson(data);
    } on ApiException catch (error) {
      if (error.isUnauthorized) {
        await _tokenStorage.deleteToken();
        return null;
      }
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _service.logout();
    } on ApiException {
      // Token lokal tetap dihapus walaupun server gagal dihubungi.
    } finally {
      await _tokenStorage.deleteToken();
    }
  }

  Future<Customer> _saveSession(Map<String, dynamic> data) async {
    final token = data['token'];
    final customer = data['customer'];

    if (token is! String || token.isEmpty || customer is! Map) {
      throw const ApiException('Respons login dari server tidak lengkap.');
    }

    await _tokenStorage.saveToken(token);
    return Customer.fromJson(Map<String, dynamic>.from(customer));
  }
}
