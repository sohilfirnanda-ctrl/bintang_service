import 'package:flutter/material.dart';

// Tema hitam-emas Bintang Service (sama dengan tampilan UTS).
const Color warnaLatar = Color(0xFF0B0B0B);
const Color warnaKartu = Color(0xFF171717);
const Color warnaKartu2 = Color(0xFF202020);
const Color warnaEmas = Color(0xFFD6B36A);
const Color warnaPutih = Color(0xFFF5F5F5);
const Color warnaAbu = Color(0xFFAAAAAA);
const Color warnaHijau = Color(0xFF55B879);
const Color warnaMerah = Color(0xFFE57373);

String formatRupiah(int angka) {
  final text = angka.abs().toString();
  final buffer = StringBuffer();

  for (int i = 0; i < text.length; i++) {
    buffer.write(text[i]);
    final sisa = text.length - i - 1;
    if (sisa > 0 && sisa % 3 == 0) {
      buffer.write('.');
    }
  }

  return '${angka < 0 ? '-' : ''}Rp${buffer.toString()}';
}

ThemeData buildAppTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: warnaLatar,
    colorScheme: const ColorScheme.dark(
      primary: warnaEmas,
      secondary: warnaEmas,
      surface: warnaKartu,
      error: warnaMerah,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: warnaLatar,
      foregroundColor: warnaEmas,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: warnaKartu2,
      labelStyle: const TextStyle(color: warnaAbu),
      hintStyle: const TextStyle(color: warnaAbu),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: warnaEmas),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: warnaMerah),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: warnaMerah, width: 1.5),
      ),
    ),
  );
}
