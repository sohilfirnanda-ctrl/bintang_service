
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bintang_service/main.dart';

void main() {
  // Pengujian 1: Halaman Login
  testWidgets(
    'Halaman login Bintang Service berhasil ditampilkan',
    (WidgetTester tester) async {
      await tester.pumpWidget(const BintangServiceApp());

      expect(find.text('Selamat Datang'), findsOneWidget);
      expect(find.text('Nama pelanggan'), findsOneWidget);
      expect(find.text('Masuk'), findsOneWidget);
    },
  );

  // Pengujian 2: Halaman Beranda
  testWidgets(
    'Halaman beranda menampilkan informasi layanan',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: HomePage(namaPelanggan: 'Bintang'),
        ),
      );

      expect(find.text('Servis Motor Anda di Sini.'), findsOneWidget);
      expect(find.text('Layanan Bengkel'), findsOneWidget);
      expect(find.text('Pilih Servis'), findsOneWidget);
    },
  );

  // Pengujian 3: Halaman Pemilihan Layanan
  testWidgets(
    'Halaman pemilihan layanan menampilkan informasi utama',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ServiceSelectionPage(namaPelanggan: 'Bintang'),
        ),
      );

      expect(find.text('Pilih Pekerjaan'), findsOneWidget);
      expect(find.text('Apa yang ingin diservis?'), findsOneWidget);
      expect(find.text('Pilihan Anda'), findsOneWidget);
      expect(find.text('Total sementara'), findsOneWidget);
      expect(find.text('Lanjut ke Booking'), findsOneWidget);
    },
  );
}
