# Project Guidelines — Bintang Service

## 1. Tujuan Proyek
Membangun aplikasi pemesanan servis sepeda motor agar pelanggan dapat melihat layanan bengkel dan melakukan booking servis.

## 2. Tampilan Aplikasi
- Menggunakan Flutter.
- Menggunakan tema hitam dan emas.
- Tampilan dibuat sederhana dan mudah digunakan.
- Alur aplikasi harus mudah dipahami pelanggan.

## 3. Fitur Utama
- Login pelanggan menggunakan nama.
- Menampilkan halaman beranda.
- Menampilkan daftar layanan dan harga.
- Memungkinkan pelanggan memilih beberapa layanan.
- Mengisi data kendaraan dan jadwal servis.
- Mengirim data pemesanan ke backend.
- Menampilkan konfirmasi pemesanan berhasil.
- Menampilkan riwayat booking berdasarkan nomor telepon.

## 4. Backend dan API
- Backend menggunakan PHP.
- Database menggunakan MySQL.
- Server lokal menggunakan Laragon.
- Komunikasi frontend dan backend menggunakan JSON.

### Daftar Endpoint
| Endpoint | Metode | Fungsi |
|---|---|---|
| index.php | GET | Memeriksa backend |
| services.php | GET | Mengambil daftar layanan |
| bookings.php | POST | Membuat pemesanan |
| booking_history.php | GET | Mengambil riwayat pemesanan |

## 5. Struktur Database
Database: `bintang_service`

- customers: menyimpan data pelanggan.
- services: menyimpan daftar layanan dan harga.
- bookings: menyimpan data pemesanan.
- booking_details: menyimpan rincian layanan dalam pemesanan.

## 6. Pengujian
- Jalankan `flutter pub get`.
- Jalankan `flutter analyze`.
- Jalankan `flutter test`.
- Jalankan aplikasi Flutter.
- Periksa komunikasi frontend dengan backend.
- Periksa proses pemesanan dan riwayat booking.

## 7. Pengelolaan Versi
Gunakan Git untuk mencatat perubahan kode dan GitHub sebagai repository proyek.

## 8. Ketentuan Perubahan
Setiap perubahan harus menjaga kesesuaian alur aplikasi, harga layanan, struktur database, dan komunikasi API. Dokumentasi harus diperbarui apabila terdapat perubahan fitur atau endpoint.