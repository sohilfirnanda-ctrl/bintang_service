import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../app_routes.dart';

/// Splash + auto-login: token di SecureStorage diverifikasi ke /api/me.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkSession());
  }

  Future<void> _checkSession() async {
    final auth = context.read<AuthViewModel>();

    await Future.wait<void>([
      auth.checkSession(),
      Future<void>.delayed(const Duration(milliseconds: 1200)),
    ]);

    if (!mounted) return;

    if (auth.status == AuthStatus.authenticated) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else if (auth.status == AuthStatus.unauthenticated) {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
    // AuthStatus.sessionError: tetap di sini dan tampilkan tombol Coba Lagi.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Consumer<AuthViewModel>(
            builder: (context, auth, _) {
              final isError = auth.status == AuthStatus.sessionError;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.two_wheeler, color: warnaEmas, size: 90),
                  const SizedBox(height: 20),
                  const Text(
                    'BINTANG SERVICE',
                    style: TextStyle(
                      color: warnaEmas,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Booking servis motor dengan mudah.',
                    style: TextStyle(color: warnaAbu),
                  ),
                  const SizedBox(height: 40),
                  if (isError) ...[
                    Text(
                      auth.errorMessage ?? 'Gagal memeriksa sesi.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: warnaMerah),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _checkSession,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Coba Lagi'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: warnaEmas,
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ] else ...[
                    const CircularProgressIndicator(color: warnaEmas),
                    const SizedBox(height: 12),
                    const Text(
                      'Memeriksa sesi...',
                      style: TextStyle(color: warnaAbu),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
