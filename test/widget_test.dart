
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:bintang_service/services/api_service.dart';

void main() {
  group('Pengujian Katalog Bintang Service', () {
    late ApiService api;

    setUp(() {
      api = ApiService(
        client: MockClient((request) async {
          if (request.url.path.endsWith('/services.php')) {
            return http.Response(
              jsonEncode({
                'success': true,
                'data': [
                  {
                    'id': 8,
                    'service_name': 'Repsol',
                    'category': 'Oli Mesin',
                    'price': 70000,
                  },
                  {
                    'id': 9,
                    'service_name': 'Shell AX5',
                    'category': 'Oli Mesin',
                    'price': 75000,
                  },
                  {
                    'id': 27,
                    'service_name': 'Oli Gardan',
                    'category': 'Oli Gear',
                    'price': 20000,
                  },
                  {
                    'id': 18,
                    'service_name': 'Servis CVT',
                    'category': 'Servis',
                    'price': 50000,
                  },
                ],
              }),
              200,
            );
          }

          return http.Response(
            jsonEncode({'success': true}),
            200,
          );
        }),
      );
    });

    test('Katalog berhasil mengambil seluruh layanan', () async {
      final hasil = await api.getServices();

      expect(hasil.length, 4);
      expect(hasil[0].nama, 'Repsol');
      expect(hasil[1].nama, 'Shell AX5');
      expect(hasil[2].nama, 'Oli Gardan');
      expect(hasil[3].nama, 'Servis CVT');
    });

    test('Setiap layanan mempunyai ID database berbeda', () async {
      final hasil = await api.getServices();

      final ids = hasil.map((item) => item.databaseId).toList();

      expect(ids.toSet().length, ids.length);
    });

    test('Dua oli mesin dapat dipilih bersamaan', () async {
      final hasil = await api.getServices();

      final pilihan = <int>{};

      pilihan.add(hasil[0].databaseId);
      pilihan.add(hasil[1].databaseId);

      expect(pilihan.length, 2);
      expect(pilihan.contains(8), true);
      expect(pilihan.contains(9), true);
    });

    test('Dua oli mesin dan oli gardan dapat dipilih bersamaan',
        () async {
      final hasil = await api.getServices();

      final pilihan = <int>{};

      pilihan.add(hasil[0].databaseId);
      pilihan.add(hasil[1].databaseId);
      pilihan.add(hasil[2].databaseId);

      expect(pilihan.length, 3);
      expect(pilihan.contains(8), true);
      expect(pilihan.contains(9), true);
      expect(pilihan.contains(27), true);
    });

    test('Total harga beberapa layanan dihitung dengan benar',
        () async {
      final hasil = await api.getServices();

      final pilihan = <int>{8, 9, 27};

      final total = hasil
          .where((item) => pilihan.contains(item.databaseId))
          .fold<int>(0, (jumlah, item) => jumlah + item.harga);

      expect(total, 165000);
    });

    test('Pilihan layanan dapat dibatalkan secara terpisah',
        () async {
      final hasil = await api.getServices();

      final pilihan = <int>{};

      pilihan.add(hasil[0].databaseId);
      pilihan.add(hasil[1].databaseId);

      pilihan.remove(hasil[0].databaseId);

      expect(pilihan.contains(8), false);
      expect(pilihan.contains(9), true);
      expect(pilihan.length, 1);
    });
  });
}
