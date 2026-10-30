
# Bintang Service

Bintang Service merupakan aplikasi pemesanan layanan bengkel motor berbasis Flutter. Aplikasi ini dibuat untuk memudahkan pelanggan melihat layanan bengkel, memilih servis, dan melakukan pemesanan secara sederhana.

## Fitur Aplikasi

1. **Login Pelanggan**
   - Pelanggan memasukkan nama sebelum masuk ke aplikasi.

2. **Beranda**
   - Menampilkan halaman utama Bintang Service.
   - Menampilkan informasi dan pilihan layanan bengkel.

3. **Pemilihan Layanan**
   - Pelanggan dapat memilih satu atau beberapa layanan servis.
   - Aplikasi menghitung total biaya berdasarkan layanan yang dipilih.
   - Pelanggan dapat memilih oli mesin yang tersedia.

4. **Form Pemesanan**
   - Mengisi informasi pemesanan servis.
   - Memilih jadwal servis.
   - Melihat ringkasan layanan dan biaya.

5. **Konfirmasi Pemesanan**
   - Menampilkan informasi bahwa pemesanan berhasil.
   - Menampilkan ringkasan pemesanan pelanggan.

## Alur Aplikasi

Login -> Beranda -> Pemilihan Layanan -> Form Pemesanan -> Konfirmasi Berhasil.

## Teknologi yang Digunakan

- Flutter
- Dart
- Material Design
- Flutter Web

## Struktur Proyek

```text
bintang_service/
|
|-- lib/
|   |-- main.dart
|
|-- test/
|   |-- widget_test.dart
|
|-- web/
|-- android/
|-- ios/
|-- windows/
|-- linux/
|-- macos/
|
|-- pubspec.yaml
|-- pubspec.lock
|-- analysis_options.yaml
|-- README.md
```

## Persyaratan Sistem

- Flutter SDK
- Dart SDK
- Google Chrome atau browser lainnya
- Sistem operasi Windows atau sistem operasi yang mendukung Flutter

## Cara Menjalankan Aplikasi

1. Buka terminal atau CMD.
2. Masuk ke direktori proyek Bintang Service.
3. Jalankan perintah berikut:

```bash
flutter pub get
```

4. Jalankan aplikasi menggunakan Flutter Web:

```bash
flutter run -d web-server --web-port 8000
```

5. Buka browser dan akses alamat:

```text
http://localhost:8000
```

## Pengujian Aplikasi

Untuk menjalankan pengujian widget:

```bash
flutter test
```

Untuk memeriksa kualitas dan kesalahan kode:

```bash
flutter analyze
```

## Status Pengembangan

Aplikasi ini merupakan proyek implementasi antarmuka Flutter dengan alur pemesanan layanan bengkel secara lokal.

Data pemesanan belum terhubung dengan database atau backend.

## Pengembang

**Bintang Service**

Proyek aplikasi pemesanan layanan bengkel motor.
