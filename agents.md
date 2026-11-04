# AGENTS.md

## Project
Bintang Service adalah aplikasi pemesanan servis sepeda motor berbasis Flutter dengan backend PHP dan database MySQL.

## Technology Stack
- Frontend: Flutter dan Dart
- Backend: PHP
- Database: MySQL
- Local server: Laragon
- Version control: Git dan GitHub

## Application Flow
1. Login pelanggan
2. Beranda
3. Pemilihan layanan
4. Form pemesanan dan jadwal
5. Konfirmasi pemesanan berhasil

## Development Guidelines
- Gunakan struktur kode Flutter yang sudah tersedia.
- Gunakan API backend untuk mengambil daftar layanan dan mengirim pemesanan.
- Validasi data sebelum dikirim ke backend.
- Gunakan respons JSON untuk komunikasi API.
- Jangan mengubah harga layanan tanpa memastikan kesesuaiannya dengan data database.
- Pastikan fitur pemesanan dapat memilih lebih dari satu layanan.
- Jalankan `flutter analyze` dan `flutter test` setelah perubahan kode.

## Database
Database: `bintang_service`

Tabel:
- customers
- services
- bookings
- booking_details

## Important
Periksa kode dan dokumentasi yang sudah ada sebelum mengubah proyek. Jangan mengarang endpoint, struktur tabel, atau fitur yang belum diterapkan.