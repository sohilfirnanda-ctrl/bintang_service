
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bintang_service/main.dart';

void main() {
  testWidgets('Halaman login Bintang Service berhasil ditampilkan',
      (WidgetTester tester) async {
    await tester.pumpWidget(const BintangServiceApp());

    expect(find.text('Selamat Datang'), findsOneWidget);
    expect(find.text('Nama pelanggan'), findsOneWidget);
    expect(find.text('Masuk'), findsOneWidget);
  });

  testWidgets('Halaman beranda menampilkan informasi layanan',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomePage(namaPelanggan: 'Bintang'),
      ),
    );

    expect(find.text('Servis Motor Anda di Sini.'), findsOneWidget);
    expect(find.text('Layanan Bengkel'), findsOneWidget);
    expect(find.text('Pilih Servis'), findsOneWidget);
  });
}
