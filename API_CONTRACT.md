# API CONTRACT
## Bintang Service — Backend API

### 1. Informasi Umum
- Backend: PHP
- Database: MySQL
- Server lokal: Laragon
- Format respons: JSON
- Content-Type: application/json; charset=UTF-8

### 2. Daftar Endpoint

| Endpoint | Metode | Fungsi |
|---|---|---|
| `index.php` | GET | Memeriksa status backend |
| `services.php` | GET | Mengambil daftar layanan |
| `bookings.php` | POST | Membuat pemesanan servis |
| `booking_history.php` | GET | Mengambil riwayat pemesanan |

### 3. Endpoint index.php

**Fungsi:** Memeriksa apakah backend berjalan.

Respons berhasil:
```json
{
  "status": "success",
  "message": "Backend Bintang Service berhasil dijalankan"
}
```

### 4. Endpoint services.php

**Metode:** GET

**Fungsi:** Mengambil daftar layanan dari tabel `services`.

Respons berhasil berisi:
- status
- message
- data berupa daftar layanan

Setiap layanan memuat:
- id
- code
- service_name
- category
- description
- price

Jika terjadi kesalahan database, server mengembalikan HTTP 500.

### 5. Endpoint bookings.php

**Metode:** POST

**Content-Type:** application/json

**Data permintaan:**
```json
{
  "name": "Nama Pelanggan",
  "phone": "08xxxxxxxxxx",
  "booking_date": "2026-11-06",
  "booking_time": "09:00",
  "motorcycle_type": "Motor Matic",
  "motorcycle_number": "BL 1234 AB",
  "service_ids": [1, 2]
}
```

Keterangan:
- `name`: nama pelanggan.
- `phone`: nomor telepon pelanggan.
- `booking_date`: tanggal pemesanan.
- `booking_time`: waktu pemesanan.
- `motorcycle_type`: jenis motor.
- `motorcycle_number`: nomor kendaraan.
- `service_ids`: daftar ID layanan yang dipilih.

Semua data wajib diisi dan `service_ids` harus berisi minimal satu layanan.

**Respons berhasil:**
```json
{
  "status": "success",
  "message": "Booking servis berhasil dibuat",
  "data": {
    "booking