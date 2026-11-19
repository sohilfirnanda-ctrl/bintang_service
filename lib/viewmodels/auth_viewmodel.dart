import 'package:flutter/foundation.dart';

import '../core/network/api_exception.dart';
import '../data/models/customer.dart';
import '../data/repositories/auth_repository.dart';

enum AuthStatus { unknown, checking, authenticated, unauthenticated, sessionError }

/// Mengatur sesi: auto-login (Splash), login, register, dan logout.
class AuthViewModel extends ChangeNotifier {
  AuthViewModel(this._repository);

  final AuthRepository _repository;

  AuthStatus status = AuthStatus.unknown;
  Customer? customer;
  bool isSubmitting = false;
  String? errorMessage;
  Map<String, String> fieldErrors = {};

  bool get isLoggedIn => status == AuthStatus.authenticated;

  String? fieldError(String field) => fieldErrors[field];

  /// Dipanggil Splash: cek token di SecureStorage lalu verifikasi ke /me.
  Future<void> checkSession() async {
    status = AuthStatus.checking;
    errorMessage = null;
    notifyListeners();

    try {
      final restored = await _repository.restoreSession();
      customer = restored;
      status = restored == null
          ? AuthStatus.unauthenticated
          : AuthStatus.authenticated;
    } on ApiException catch (error) {
      errorMessage = error.message;
      status = AuthStatus.sessionError;
    } catch (_) {
      errorMessage = 'Terjadi kesalahan saat memeriksa sesi.';
      status = AuthStatus.sessionError;
    }

    notifyListeners();
  }

  Future<bool> login({required String email, required String password}) {
    return _submit(
      () => _repository.login(email: email.trim(), password: password),
    );
  }

  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) {
    return _submit(
      () => _repository.register(
        name: name.trim(),
        email: email.trim(),
        phone: phone.trim(),
        password: password,
        passwordConfirmation: passwordConfirmation,
      ),
    );
  }

  Future<void> logout() async {
    isSubmitting = true;
    notifyListeners();

    await _repository.logout();

    customer = null;
    status = AuthStatus.unauthenticated;
    isSubmitting = false;
    notifyListeners();
  }

  /// Dipanggil ApiClient ketika server membalas 401 di tengah pemakaian.
  void handleSessionExpired() {
    customer = null;
    status = AuthStatus.unauthenticated;
    errorMessage = 'Sesi berakhir, silakan login kembali.';
    notifyListeners();
  }

  void clearFieldError(String field) {
    if (fieldErrors.remove(field) != null) notifyListeners();
  }

  void resetForm() {
    errorMessage = null;
    fieldErrors = {};
    notifyListeners();
  }

  Future<bool> _submit(Future<Customer> Function() action) async {
    isSubmitting = true;
    errorMessage = null;
    fieldErrors = {};
    notifyListeners();

    try {
      customer = await action();
      status = AuthStatus.authenticated;
      return true;
    } on ApiException catch (error) {
      errorMessage = error.message;
      fieldErrors = error.firstErrors;
      return false;
    } catch (_) {
      errorMessage = 'Terjadi kesalahan tak terduga. Coba lagi.';
      return false;
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }
}
