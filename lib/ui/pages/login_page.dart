import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../app_routes.dart';
import '../widgets/error_banner.dart';
import '../widgets/tombol_utama.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    FocusScope.of(context).unfocus();
    final auth = context.read<AuthViewModel>();

    final success = await auth.login(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (!mounted) return;
    if (success) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
      );
    }
  }

  Future<void> _openRegister() async {
    final auth = context.read<AuthViewModel>();
    auth.resetForm();
    await Navigator.pushNamed(context, AppRoutes.register);
    if (!mounted) return;
    auth.resetForm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    const Center(
                      child: Icon(Icons.two_wheeler, color: warnaEmas, size: 70),
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'BINTANG SERVICE',
                        style: TextStyle(
                          color: warnaEmas,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
                    const Text(
                      'Masuk Pelanggan',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      key: const Key('login_email'),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (_) => auth.clearFieldError('email'),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'rahmat@example.com',
                        prefixIcon: const Icon(Icons.email_outlined),
                        errorText: auth.fieldError('email'),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      key: const Key('login_password'),
                      controller: _passwordController,
                      obscureText: _obscure,
                      onChanged: (_) => auth.clearFieldError('password'),
                      onSubmitted: (_) => _login(),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        errorText: auth.fieldError('password'),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscure ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (auth.errorMessage != null) ...[
                      ErrorBanner(message: auth.errorMessage!),
                      const SizedBox(height: 16),
                    ],
                    TombolUtama(
                      teks: 'MASUK',
                      isLoading: auth.isSubmitting,
                      onPressed: _login,
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: TextButton(
                        onPressed: auth.isSubmitting ? null : _openRegister,
                        child: const Text(
                          'Belum punya akun? Daftar',
                          style: TextStyle(color: warnaEmas),
                        ),
                      ),
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
