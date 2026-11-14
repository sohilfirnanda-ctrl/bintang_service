import 'package:bintang_service/core/network/api_exception.dart';
import 'package:bintang_service/core/state/view_status.dart';
import 'package:bintang_service/data/models/booking.dart';
import 'package:bintang_service/data/models/customer.dart';
import 'package:bintang_service/data/models/service_item.dart';
import 'package:bintang_service/data/repositories/auth_repository.dart';
import 'package:bintang_service/data/repositories/booking_repository.dart';
import 'package:bintang_service/data/repositories/layanan_repository.dart';
import 'package:bintang_service/viewmodels/auth_viewmodel.dart';
import 'package:bintang_service/viewmodels/booking_viewmodel.dart';
import 'package:bintang_service/viewmodels/layanan_detail_viewmodel.dart';
import 'package:bintang_service/viewmodels/layanan_list_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

// ------------------------------------------------------------
// Repository palsu: ViewModel diuji tanpa server sungguhan.
// ------------------------------------------------------------

const _oli = ServiceItem(
  id: 1,
  name: 'Ganti Oli Mesin',
  description: 'Penggantian oli mesin.',
  price: 55000,
  durationMinutes: 20,
  isActive: true,
);

const _cvt = ServiceItem(
  id: 5,
  name: 'Servis CVT',
  description: 'Pembersihan CVT.',
  price: 90000,
  durationMinutes: 60,
  isActive: true,
);

const _customer = Customer(
  id: 2,
  name: 'Rahmat Hidayat',
  email: 'rahmat@example.com',
  phone: '081277700011',
  role: 'customer',
);

const _networkError = ApiException(
  'Tidak dapat terhubung ke server.',
  type: ApiErrorType.network,
);

class FakeLayananRepository implements LayananRepository {
  List<ServiceItem> services = [_oli, _cvt];
  ApiException? error;
  String? lastSearch;

  @override
  Future<List<ServiceItem>> getServices({String search = ''}) async {
    lastSearch = search;
    final current = error;
    if (current != null) throw current;
    return services;
  }

  @override
  Future<ServiceItem> getServiceDetail(int id) async {
    final current = error;
    if (current != null) throw current;
    return services.firstWhere((service) => service.id == id);
  }
}

class FakeAuthRepository implements AuthRepository {
  ApiException? error;
  Customer? session;

  @override
  Future<Customer> login({
    required String email,
    required String password,
  }) async {
    final current = error;
    if (current != null) throw current;
    return _customer;
  }

  @override
  Future<Customer> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    final current = error;
    if (current != null) throw current;
    return _customer;
  }

  @override
  Future<Customer?> restoreSession() async {
    final current = error;
    if (current != null) throw current;
    return session;
  }

  @override
  Future<void> logout() async {}
}

class FakeBookingRepository implements BookingRepository {
  ApiException? error;

  @override
  Future<Booking> createBooking({
    required String motorType,
    required String plateNumber,
    required String bookingDate,
    required String bookingTime,
    required String complaint,
    required List<int> serviceIds,
  }) async {
    final current = error;
    if (current != null) throw current;
    return Booking(
      id: 10,
      bookingCode: 'BS-20261115-ABCDE',
      motorType: motorType,
      plateNumber: plateNumber,
      bookingDate: bookingDate,
      bookingTime: bookingTime,
      complaint: null,
      status: 'pending',
      totalPrice: 145000,
      details: const [],
      createdAt: '2026-11-15 09:00:00',
    );
  }

  @override
  Future<List<Booking>> getMyBookings() async => [];
}

void main() {
  group('LayananListViewModel', () {
    late FakeLayananRepository repository;
    late LayananListViewModel viewModel;

    setUp(() {
      repository = FakeLayananRepository();
      viewModel = LayananListViewModel(repository);
    });

    test('memuat data -> status success', () async {
      await viewModel.load();

      expect(viewModel.status, ViewStatus.success);
      expect(viewModel.services.length, 2);
    });

    test('data kosong -> status empty', () async {
      repository.services = [];
      await viewModel.load();

      expect(viewModel.status, ViewStatus.empty);
    });

    test('backend mati -> error, lalu Retry setelah backend hidup -> success',
        () async {
      repository.error = _networkError;
      await viewModel.load();
      expect(viewModel.status, ViewStatus.error);
      expect(viewModel.errorMessage, isNotNull);

      repository.error = null;
      await viewModel.retry();
      expect(viewModel.status, ViewStatus.success);
    });

    test('filter mengirim kata kunci pencarian ke repository', () async {
      await viewModel.search('  oli ');

      expect(repository.lastSearch, 'oli');
      expect(viewModel.query, 'oli');
    });

    test('memilih layanan menghitung total harga', () {
      viewModel.toggle(_oli);
      viewModel.toggle(_cvt);
      expect(viewModel.selectedCount, 2);
      expect(viewModel.selectedTotal, 145000);

      viewModel.toggle(_oli);
      expect(viewModel.selectedTotal, 90000);
    });
  });

  group('LayananDetailViewModel', () {
    test('error lalu Retry berhasil memuat detail', () async {
      final repository = FakeLayananRepository()..error = _networkError;
      final viewModel = LayananDetailViewModel(repository);

      await viewModel.load(5);
      expect(viewModel.status, ViewStatus.error);

      repository.error = null;
      await viewModel.retry();
      expect(viewModel.status, ViewStatus.success);
      expect(viewModel.service?.name, 'Servis CVT');
    });
  });

  group('AuthViewModel', () {
    late FakeAuthRepository repository;
    late AuthViewModel viewModel;

    setUp(() {
      repository = FakeAuthRepository();
      viewModel = AuthViewModel(repository);
    });

    test('login berhasil -> authenticated', () async {
      final success = await viewModel.login(
        email: 'rahmat@example.com',
        password: 'password123',
      );

      expect(success, isTrue);
      expect(viewModel.status, AuthStatus.authenticated);
      expect(viewModel.customer?.name, 'Rahmat Hidayat');
    });

    test('register dengan data salah -> error 422 per field', () async {
      repository.error = const ApiException(
        'Data yang dikirim tidak valid.',
        type: ApiErrorType.validation,
        statusCode: 422,
        fieldErrors: {
          'email': ['The email has already been taken.'],
          'password': ['The password field must be at least 8 characters.'],
        },
      );

      final success = await viewModel.register(
        name: 'Uji',
        email: 'rahmat@example.com',
        phone: '0812',
        password: '123',
        passwordConfirmation: '123',
      );

      expect(success, isFalse);
      expect(viewModel.fieldError('email'), 'The email has already been taken.');
      expect(viewModel.fieldError('password'), isNotNull);

      viewModel.clearFieldError('email');
      expect(viewModel.fieldError('email'), isNull);
    });

    test('auto-login: token valid -> authenticated', () async {
      repository.session = _customer;
      await viewModel.checkSession();

      expect(viewModel.status, AuthStatus.authenticated);
    });

    test('auto-login: belum ada token -> unauthenticated', () async {
      await viewModel.checkSession();

      expect(viewModel.status, AuthStatus.unauthenticated);
    });

    test('auto-login saat backend mati -> sessionError (tampil Coba Lagi)',
        () async {
      repository.error = _networkError;
      await viewModel.checkSession();

      expect(viewModel.status, AuthStatus.sessionError);
    });

    test('logout -> unauthenticated dan data pelanggan dihapus', () async {
      await viewModel.login(
        email: 'rahmat@example.com',
        password: 'password123',
      );
      await viewModel.logout();

      expect(viewModel.status, AuthStatus.unauthenticated);
      expect(viewModel.customer, isNull);
    });
  });

  group('BookingViewModel', () {
    test('booking valid -> createdBooking terisi', () async {
      final viewModel = BookingViewModel(FakeBookingRepository());

      final success = await viewModel.submit(
        motorType: 'Honda Vario 125',
        plateNumber: 'BL 1234 AB',
        bookingDate: '2026-11-20',
        bookingTime: '09:00',
        complaint: '',
        serviceIds: [1, 5],
      );

      expect(success, isTrue);
      expect(viewModel.createdBooking?.bookingCode, 'BS-20261115-ABCDE');
    });

    test('booking kosong -> error 422 tampil per field', () async {
      final repository = FakeBookingRepository()
        ..error = const ApiException(
          'Data yang dikirim tidak valid.',
          type: ApiErrorType.validation,
          statusCode: 422,
          fieldErrors: {
            'motor_type': ['The motor type field is required.'],
            'booking_date': ['The booking date field is required.'],
            'service_ids': ['The service ids field is required.'],
          },
        );
      final viewModel = BookingViewModel(repository);

      final success = await viewModel.submit(
        motorType: '',
        plateNumber: '',
        bookingDate: '',
        bookingTime: '',
        complaint: '',
        serviceIds: [],
      );

      expect(success, isFalse);
      expect(viewModel.fieldError('motor_type'), isNotNull);
      expect(viewModel.fieldError('booking_date'), isNotNull);
      expect(viewModel.servicesError, 'The service ids field is required.');
    });
  });
}
