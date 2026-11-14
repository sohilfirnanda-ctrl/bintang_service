import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/network/api_client.dart';
import 'core/storage/token_storage.dart';
import 'core/theme/app_theme.dart';
import 'data/models/booking.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/booking_repository.dart';
import 'data/repositories/layanan_repository.dart';
import 'data/services/auth_service.dart';
import 'data/services/booking_service.dart';
import 'data/services/layanan_service.dart';
import 'ui/app_routes.dart';
import 'ui/pages/booking_form_page.dart';
import 'ui/pages/booking_success_page.dart';
import 'ui/pages/home_page.dart';
import 'ui/pages/layanan_detail_page.dart';
import 'ui/pages/login_page.dart';
import 'ui/pages/register_page.dart';
import 'ui/pages/riwayat_page.dart';
import 'ui/pages/splash_page.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/booking_viewmodel.dart';
import 'viewmodels/layanan_detail_viewmodel.dart';
import 'viewmodels/layanan_list_viewmodel.dart';
import 'viewmodels/riwayat_viewmodel.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Susunan lapisan: ApiClient (Dio) -> Service -> Repository -> ViewModel -> Widget
  final tokenStorage = TokenStorage();
  final apiClient = ApiClient(tokenStorage: tokenStorage);

  final authRepository = AuthRepository(
    service: AuthService(apiClient),
    tokenStorage: tokenStorage,
  );
  final layananRepository = LayananRepository(LayananService(apiClient));
  final bookingRepository = BookingRepository(BookingService(apiClient));

  final authViewModel = AuthViewModel(authRepository);
  final layananListViewModel = LayananListViewModel(layananRepository);

  // Token ditolak server (401) di tengah pemakaian -> kembali ke login.
  apiClient.onUnauthorized = () {
    authViewModel.handleSessionExpired();
    layananListViewModel.reset();
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      AppRoutes.login,
      (route) => false,
    );
  };

  runApp(
    MultiProvider(
      providers: [
        Provider<LayananRepository>.value(value: layananRepository),
        Provider<BookingRepository>.value(value: bookingRepository),
        ChangeNotifierProvider<AuthViewModel>.value(value: authViewModel),
        ChangeNotifierProvider<LayananListViewModel>.value(
          value: layananListViewModel,
        ),
      ],
      child: const BintangServiceApp(),
    ),
  );
}

class BintangServiceApp extends StatelessWidget {
  const BintangServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bintang Service',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: buildAppTheme(),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: _onGenerateRoute,
    );
  }

  static Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    final Widget page;

    switch (settings.name) {
      case AppRoutes.login:
        page = const LoginPage();
      case AppRoutes.register:
        page = const RegisterPage();
      case AppRoutes.home:
        page = const HomePage();
      case AppRoutes.layananDetail:
        final serviceId = settings.arguments as int;
        page = ChangeNotifierProvider(
          create: (context) =>
              LayananDetailViewModel(context.read<LayananRepository>()),
          child: LayananDetailPage(serviceId: serviceId),
        );
      case AppRoutes.bookingForm:
        page = ChangeNotifierProvider(
          create: (context) =>
              BookingViewModel(context.read<BookingRepository>()),
          child: const BookingFormPage(),
        );
      case AppRoutes.bookingSuccess:
        page = BookingSuccessPage(booking: settings.arguments as Booking?);
      case AppRoutes.riwayat:
        page = ChangeNotifierProvider(
          create: (context) =>
              RiwayatViewModel(context.read<BookingRepository>()),
          child: const RiwayatPage(),
        );
      default:
        page = const SplashPage();
    }

    return MaterialPageRoute<dynamic>(builder: (_) => page, settings: settings);
  }
}
