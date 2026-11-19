# Pertemuan 10 — Integrasi End-to-End Flutter ↔ Laravel

Aplikasi Flutter **Bintang Service** kini terhubung ke backend Laravel
`bintang_service_api` (Pertemuan 9) melalui Dio, Repository Pattern,
Provider, dan flutter_secure_storage.

## 1. Arsitektur

```
Widget (ui/pages)  ──>  ViewModel (Provider/ChangeNotifier)
                          │
                          ▼
                     Repository (data/repositories)   ← mengubah JSON jadi model, kelola token
                          │
                          ▼
                     Service (data/services)          ← memanggil endpoint mentah
                          │
                          ▼
                     ApiClient (core/network, Dio)    ← header Bearer, mapping error
                          │
                          ▼
                     Laravel API  http://<host>:8000/api
```

| Lapisan | File |
|---|---|
| Konfigurasi & token | `core/config/api_config.dart`, `core/storage/token_storage.dart` |
| HTTP & error | `core/network/api_client.dart`, `core/network/api_exception.dart` |
| Model | `data/models/customer.dart`, `service_item.dart`, `booking.dart` |
| Service | `data/services/auth_service.dart`, `layanan_service.dart`, `booking_service.dart` |
| Repository (3) | `data/repositories/auth_repository.dart`, `layanan_repository.dart`, `booking_repository.dart` |
| ViewModel | `AuthViewModel` (+ Splash/auto-login), `LayananListViewModel`, `BookingViewModel`, `LayananDetailViewModel`, `RiwayatViewModel` |
| Halaman | Splash, Login, Register, Home (list + filter), Detail Layanan, Form Booking, Booking Sukses, Riwayat |

### Endpoint yang dipakai

| Flow | Endpoint |
|---|---|
| Register | `POST /api/register` |
| Login | `POST /api/login` |
| Auto-login | `GET /api/me` (token dari SecureStorage) |
| Logout | `POST /api/logout` |
| List + filter | `GET /api/services?search=...` |
| Detail | `GET /api/services/{id}` |
| Create booking | `POST /api/bookings` |
| Riwayat | `GET /api/bookings` |

## 2. Cara Menjalankan

**Backend** (`C:\laragon\www\bintang_service_api`):

```bash
# Pastikan MySQL Laragon sudah Start
php artisan migrate:fresh --seed
php artisan serve
```

**Flutter** (`C:\Users\ACER\Documents\bintang_service`):

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

Alamat backend dipilih otomatis:

| Target | Base URL |
|---|---|
| Emulator Android | `http://10.0.2.2:8000/api` |
| Windows / Chrome | `http://127.0.0.1:8000/api` |
| HP fisik | `flutter run --dart-define=API_BASE_URL=http://IP-LAPTOP:8000/api` dan backend dijalankan dengan `php artisan serve --host=0.0.0.0` |

Akun demo dari seeder: `rahmat@example.com` / `password123`.

## 3. Naskah Video Demo (±3 menit)

| Waktu | Yang ditunjukkan |
|---|---|
| 0:00–0:30 | Buka aplikasi yang sudah pernah login → Splash "Memeriksa sesi..." → langsung masuk Beranda (auto-login). |
| 0:30–1:00 | Logout → Daftar akun baru (coba sekali dengan data salah agar error 422 tampil per field, lalu data benar) → masuk Beranda → Logout. |
| 1:00–1:30 | Login `rahmat@example.com` → daftar layanan dari database tampil. Tarik ke bawah untuk refresh. |
| 1:30–2:00 | Ketik "oli" di kolom cari (filter) → buka detail layanan → Pilih layanan. |
| 2:00–2:30 | Pilih 2 layanan → Lanjut Booking → tekan Kirim kosong (error 422 per field) → isi lengkap → Booking Berhasil → Lihat Riwayat. |
| 2:30–3:00 | Matikan `php artisan serve` (Ctrl+C) → refresh Beranda → tampil error + tombol **Coba Lagi** → jalankan lagi `php artisan serve` → tekan Coba Lagi → data pulih. |

## 4. Sepuluh Skenario Test End-to-End

Isi kolom **Hasil** setelah dicoba di aplikasi.

| No | Skenario | Langkah | Hasil yang diharapkan | Hasil |
|---|---|---|---|---|
| 1 | Auto-login | Login, tutup aplikasi, buka lagi | Splash → langsung Beranda tanpa login ulang | ☐ Lulus ☐ Gagal |
| 2 | Register valid | Isi nama, email baru, HP 08xxxxxxxxxx, password ≥ 8 & konfirmasi sama | Akun dibuat (201), token tersimpan, masuk Beranda | ☐ Lulus ☐ Gagal |
| 3 | Register tidak valid (422) | Email yang sudah terdaftar, HP "0812", password "123" | Pesan error tampil di bawah field email, phone, password | ☐ Lulus ☐ Gagal |
| 4 | Login salah (401) | Email benar, password salah | Kotak merah "Email atau password salah." | ☐ Lulus ☐ Gagal |
| 5 | Login valid + list | Login `rahmat@example.com` / `password123` | Daftar layanan dari database tampil (loading → success) | ☐ Lulus ☐ Gagal |
| 6 | Filter kosong (empty state) | Cari "zzz" | Tampil "Layanan "zzz" tidak ditemukan." | ☐ Lulus ☐ Gagal |
| 7 | Filter + detail | Cari "oli", buka item | Detail layanan dari `GET /services/{id}` tampil | ☐ Lulus ☐ Gagal |
| 8 | Booking tidak valid (422) | Pilih layanan, tekan Kirim tanpa isi form | Error per field: jenis motor, nomor polisi, tanggal, jam | ☐ Lulus ☐ Gagal |
| 9 | Booking valid | Isi form lengkap, Kirim | Halaman sukses dengan kode `BS-...` dan total harga; muncul di Riwayat | ☐ Lulus ☐ Gagal |
| 10 | Backend mati → pulih | Hentikan `php artisan serve`, refresh, lalu nyalakan lagi dan tekan Coba Lagi | Error + tombol Coba Lagi, lalu data tampil kembali | ☐ Lulus ☐ Gagal |

### Unit test otomatis (`flutter test`)

- `test/api_exception_test.dart`: mapping 422, 401, 500, koneksi putus, timeout.
- `test/viewmodels_test.dart`: state loading/success/empty/error + Retry, filter,
  total layanan, login, register 422, auto-login, logout, booking valid & 422.

## 5. Template Pengumpulan SPADA

```
Nama kelompok   :
Anggota         :
Repo frontend   : https://github.com/sohilfirnanda-ctrl/bintang_service
Repo backend    :
Pull Request    :
Video demo      :
Atomic commit   :
Ringkasan 10 skenario test: 10/10 lulus (lihat docs/PERTEMUAN10_INTEGRASI.md)
```
