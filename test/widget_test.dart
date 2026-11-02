
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:bintang_service/main.dart';
import 'package:bintang_service/services/api_service.dart';

void main() {
  // ============================================================
  // TEST 1: HALAMAN LOGIN
  // ============================================================

  testWidgets(
    'Halaman login Bintang Service berhasil ditampilkan',
    (WidgetTester tester) async {
      await tester.pumpWidget(const BintangServiceApp());

      expect(find.text('Selamat Datang'), findsOneWidget);
      expect(find.text('Nama pelanggan'), findsOneWidget);
      expect(find.text('MASUK KE APLIKASI'), findsOneWidget);
    },
  );

  // ============================================================
  // TEST 2: HALAMAN BERANDA
  // ============================================================

  testWidgets(
    'Halaman beranda menampilkan informasi layanan',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: HomePage(
            namaPelanggan: 'Bintang',
          ),
        ),
      );

      expect(find.text('Halo, Bintang'), findsOneWidget);
      expect(
        find.text('Servis Motor\nAnda di Sini.'),
        findsOneWidget,
      );
      expect(
        find.text('Layanan Bintang Service'),
        findsOneWidget,
      );
    },
  );

  // ============================================================
  // TEST 3: KATALOG LAYANAN DAN HARGA DARI SIMULASI API
  // ============================================================

  testWidgets(
    'Katalog menampilkan layanan dan harga dari simulasi API',
    (WidgetTester tester) async {
      ApiService.client = MockClient((request) async {
        if (request.url.path.endsWith('/services.php')) {
          return http.Response(
            jsonEncode({
              'status': 'success',
              'data': [
                {
                  'id': 18,
                  'code': 'cvt',
                  'service_name': 'Servis CVT',
                  'category': 'Servis Mesin',
                  'price': '50000.00',
                  'description':
                      'Pembersihan dan pemeriksaan CVT',
                },
                {
                  'id': 27,
                  'code': 'oli_gardan',
                  'service_name': 'Oli Gear',
                  'category': 'Oli Gear',
                  'price': '20000.00',
                  'description': 'Penggantian oli gear',
                },
              ],
            }),
            200,
            headers: {
              'content-type': 'application/json',
            },
          );
        }

        return http.Response(
          jsonEncode({
            'status': 'error',
            'message': 'Endpoint tidak ditemukan',
          }),
          404,
        );
      });

      addTearDown(() {
        ApiService.client.close();
      });

      await tester.pumpWidget(
        const MaterialApp(
          home: ServiceSelectionPage(
            namaPelanggan: 'Bintang',
          ),
        ),
      );

      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('Katalog Layanan'), findsOneWidget);
      expect(
        find.text('PILIH KEBUTUHAN MOTOR'),
        findsOneWidget,
      );

      expect(find.text('Servis CVT'), findsOneWidget);

      // Oli Gear muncul sebagai nama kategori dan nama layanan.
      expect(find.text('Oli Gear'), findsNWidgets(2));

      expect(find.text('Rp50.000'), findsOneWidget);
      expect(find.text('Rp20.000'), findsOneWidget);

      expect(find.text('TOTAL HARGA'), findsOneWidget);
      expect(
        find.text('LANJUTKAN PEMESANAN'),
        findsOneWidget,
      );
    },
  );

  // ============================================================
  // TEST 4: PEMILIHAN OLI MESIN DAN OLI GEAR
  // ============================================================

  testWidgets(
    'Oli Mesin dan Oli Gear dapat dipilih secara terpisah',
    (WidgetTester tester) async {
      ApiService.client = MockClient((request) async {
        return http.Response(
          jsonEncode({
            'status': 'success',
            'data': [
              {
                'id': 8,
                'code': 'oli_repsol',
                'service_name': 'Oli Repsol',
                'category': 'Oli Mesin',
                'price': '70000.00',
                'description': 'Oli mesin Repsol',
              },
              {
                'id': 27,
                'code': 'oli_gardan',
                'service_name': 'Oli Gear',
                'category': 'Oli Gear',
                'price': '20000.00',
                'description': 'Oli gear motor',
              },
            ],
          }),
          200,
          headers: {
            'content-type': 'application/json',
          },
        );
      });

      addTearDown(() {
        ApiService.client.close();
      });

      await tester.pumpWidget(
        const MaterialApp(
          home: ServiceSelectionPage(
            namaPelanggan: 'Bintang',
          ),
        ),
      );

      await tester.pump();
      await tester.pumpAndSettle();

      // Pilih Oli Repsol.
      final oliRepsolFinder = find.text('Oli Repsol');

      await tester.ensureVisible(oliRepsolFinder);
      await tester.tap(oliRepsolFinder);
      await tester.pumpAndSettle();

      // Pilih nama layanan Oli Gear, bukan judul kategorinya.
      final oliGearFinder = find.text('Oli Gear').last;

      await tester.ensureVisible(oliGearFinder);
      await tester.tap(oliGearFinder);
      await tester.pumpAndSettle();

      // Pastikan dua layanan berhasil dipilih.
      expect(
        find.text('2 layanan dipilih'),
        findsOneWidget,
      );

      // Rp70.000 + Rp20.000 = Rp90.000.
      expect(find.text('Rp90.000'), findsOneWidget);
    },
  );
}
