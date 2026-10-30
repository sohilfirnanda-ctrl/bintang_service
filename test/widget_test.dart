
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
}
