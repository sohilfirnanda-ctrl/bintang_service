import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../app_routes.dart';
import '../widgets/error_banner.dart';
import '../widgets/tombol_utama.dart';

/// Validasi sengaja dilakukan oleh server (Laravel) agar error 422
/// tampil per field di bawah masing-masing input.
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    FocusScope.of(context).unfocus();
    final auth = context.read<AuthViewModel>();

    final success = await auth.register(
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      password: _passwordController.text,
      passwordConfirmation: _confirmController.text,
    );

    if (!mounted) return;
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrasi berhasil. Selamat datang!')),
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
      );
    }
  }

  Widget _field({
    required AuthViewModel auth,
    required TextEditingController controller,
    required String field,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        key: Key('register_$field'),
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscure,
        onChanged: (_) => auth.clearFieldError(field),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          errorText: auth.fieldError(field),
          errorMaxLines: 3,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Akun')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Consumer<AuthViewModel>(
              builder: (context, auth, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _field(
                      auth: auth,
                      controller: _nameController,
                      field: 'name',
                      label: 'Nama lengkap',
                      icon: Icons.person_outline,
                    ),
                    _field(
                      auth: auth,
                      controller: _emailController,
                      field: 'email',
                      label: 'Email',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    _field(
                      auth: auth,
                      controller: _phoneController,
                      field: 'phone',
                      label: 'Nomor HP (08xxxxxxxxxx)',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                    _field(
                      auth: auth,
                      controller: _passwordController,
                      field: 'password',
                      label: 'Password (min. 8 karakter)',
                      icon: Icons.lock_outline,
                      obscure: true,
                    ),
                    _field(
                      auth: auth,
                      controller: _confirmController,
                      field: 'password_confirmation',
                      label: 'Ulangi password',
                      icon: Icons.lock_reset,
                      obscure: true,
                    ),
                    const SizedBox(height: 5),
                    if (auth.errorMessage != null) ...[
                      ErrorBanner(message: auth.errorMessage!),
                      const SizedBox(height: 16),
                    ],
                    TombolUtama(
                      teks: 'DAFTAR',
                      isLoading: auth.isSubmitting,
                      onPressed: _register,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
