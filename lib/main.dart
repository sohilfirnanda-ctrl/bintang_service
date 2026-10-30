
import 'package:flutter/material.dart';

void main() {
  runApp(const BintangServiceApp());
}

// ============================================================
// WARNA DAN TEMA
// ============================================================

const Color warnaLatar = Color(0xFF151515);
const Color warnaKartu = Color(0xFF242424);
const Color warnaEmas = Color(0xFFD8BD83);
const Color warnaTeks = Color(0xFFF5F0E6);
const Color warnaSekunder = Color(0xFFB8B1A5);
const Color warnaGaris = Color(0xFF454545);

// ============================================================
// MODEL LAYANAN
// ============================================================

class ServiceItem {
  final String id;
  final String nama;
  final String kategori;
  final int harga;
  final String keterangan;

  const ServiceItem({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.harga,
    this.keterangan = '',
  });
}

// ============================================================
// KATALOG OLI
// Harga sesuai daftar yang diberikan pemilik Bintang Service.
// ============================================================

const List<ServiceItem> daftarOli = [
  ServiceItem(
    id: 'oli_repsol',
    nama: 'Repsol',
    kategori: 'Oli Mesin',
    harga: 70000,
  ),
  ServiceItem(
    id: 'oli_mpx2',
    nama: 'AHM Oil MPX2',
    kategori: 'Oli Mesin',
    harga: 90000,
  ),
  ServiceItem(
    id: 'oli_spx2',
    nama: 'AHM Oil SPX2',
    kategori: 'Oli Mesin',
    harga: 105000,
  ),
  ServiceItem(
    id: 'oli_ax5',
    nama: 'Shell AX5',
    kategori: 'Oli Mesin',
    harga: 75000,
  ),
  ServiceItem(
    id: 'oli_ax7',
    nama: 'Shell AX7',
    kategori: 'Oli Mesin',
    harga: 85000,
  ),
  ServiceItem(
    id: 'oli_yamalube_silver',
    nama: 'Yamalube Silver',
    kategori: 'Oli Mesin',
    harga: 60000,
  ),
  ServiceItem(
    id: 'oli_yamalube_matic',
    nama: 'Yamalube Matic',
    kategori: 'Oli Mesin',
    harga: 65000,
  ),
  ServiceItem(
    id: 'oli_yamalube_sport',
    nama: 'Yamalube Sport',
    kategori: 'Oli Mesin',
    harga: 90000,
  ),
  ServiceItem(
    id: 'oli_yamalube_super',
    nama: 'Yamalube Super Matic',
    kategori: 'Oli Mesin',
    harga: 95000,
  ),
];

// ============================================================
// KATALOG JASA DAN PRODUK TAMBAHAN
// ============================================================

const List<ServiceItem> daftarLayanan = [
  ServiceItem(
    id: 'tb',
    nama: 'Servis TB + Bersihkan Filter Udara',
    kategori: 'Servis Injeksi',
    harga: 50000,
  ),
  ServiceItem(
    id: 'cvt',
    nama: 'Servis CVT',
    kategori: 'Servis Mesin',
    harga: 50000,
    keterangan: 'Harga servis tanpa penggantian barang.',
  ),
  ServiceItem(
    id: 'shock',
    nama: 'Servis Shock Depan Kiri dan Kanan',
    kategori: 'Kaki-kaki',
    harga: 130000,
  ),
  ServiceItem(
    id: 'infus',
    nama: 'Infus Injeksi',
    kategori: 'Servis Injeksi',
    harga: 30000,
  ),
  ServiceItem(
    id: 'rotak',
    nama: 'Ganti Rotak, Karet, dan Saringan Minyak',
    kategori: 'Servis Injeksi',
    harga: 200000,
  ),
  ServiceItem(
    id: 'kampas_depan',
    nama: 'Ganti Kampas Rem Depan',
    kategori: 'Rem',
    harga: 40000,
  ),
  ServiceItem(
    id: 'kampas_belakang',
    nama: 'Ganti Kampas Rem Belakang',
    kategori: 'Rem',
    harga: 65000,
  ),
  ServiceItem(
    id: 'busi',
    nama: 'Ganti Busi',
    kategori: 'Mesin',
    harga: 20000,
  ),
  ServiceItem(
    id: 'komstir',
    nama: 'Servis Komstir',
    kategori: 'Kaki-kaki',
    harga: 150000,
  ),
  ServiceItem(
    id: 'bearing',
    nama: 'Ganti Bearing Roda',
    kategori: 'Roda',
    harga: 60000,
  ),
  ServiceItem(
    id: 'pasang_ban_depan',
    nama: 'Jasa Pasang Ban Depan',
    kategori: 'Ban',
    harga: 20000,
    keterangan: 'Harga jasa pemasangan saja.',
  ),
  ServiceItem(
    id: 'pasang_ban_belakang',
    nama: 'Jasa Pasang Ban Belakang',
    kategori: 'Ban',
    harga: 25000,
    keterangan: 'Harga jasa pemasangan saja.',
  ),
  ServiceItem(
    id: 'tambal_tubeless',
    nama: 'Tambal Ban Tubeless',
    kategori: 'Ban',
    harga: 15000,
  ),
  ServiceItem(
    id: 'aki',
    nama: 'Ganti Aki',
    kategori: 'Kelistrikan',
    harga: 210000,
  ),
  ServiceItem(
    id: 'oli_gardan',
    nama: 'Ganti Oli Gardan',
    kategori: 'Oli',
    harga: 20000,
  ),
  ServiceItem(
    id: 'celah_klep',
    nama: 'Pemeriksaan Celah Klep',
    kategori: 'Mesin',
    harga: 30000,
  ),
  ServiceItem(
    id: 'cairan_tubeless',
    nama: 'Cairan Tubeless',
    kategori: 'Produk',
    harga: 35000,
  ),
  ServiceItem(
    id: 'tambal_dalam',
    nama: 'Tambal Ban Dalam',
    kategori: 'Ban',
    harga: 15000,
  ),
  ServiceItem(
    id: 'ganti_dalam',
    nama: 'Ganti Ban Dalam',
    kategori: 'Ban',
    harga: 45000,
  ),
  ServiceItem(
    id: 'karburator',
    nama: 'Servis Karburator',
    kategori: 'Karburator',
    harga: 45000,
  ),
  ServiceItem(
    id: 'minyak_rem',
    nama: 'Ganti Minyak Rem',
    kategori: 'Rem',
    harga: 10000,
  ),
  ServiceItem(
    id: 'kaliper',
    nama: 'Servis Kaliper Rem',
    kategori: 'Rem',
    harga: 40000,
  ),
  ServiceItem(
    id: 'pentil',
    nama: 'Ganti Pentil Ban',
    kategori: 'Ban',
    harga: 30000,
  ),
  ServiceItem(
    id: 'ringan_karbu',
    nama: 'Servis Ringan Motor Karburator',
    kategori: 'Karburator',
    harga: 35000,
  ),
  ServiceItem(
    id: 'rantai',
    nama: 'Setel Rantai Motor Bebek/Sport',
    kategori: 'Rantai',
    harga: 10000,
  ),
];

// ============================================================
// FORMAT RUPIAH
// ============================================================

String rupiah(int angka) {
  final String nilai = angka.toString();
  final StringBuffer hasil = StringBuffer();

  for (int i = 0; i < nilai.length; i++) {
    hasil.write(nilai[i]);

    final int sisa = nilai.length - i - 1;

    if (sisa > 0 && sisa % 3 == 0) {
      hasil.write('.');
    }
  }

  return 'Rp$hasil';
}

// ============================================================
// APLIKASI UTAMA
// ============================================================

class BintangServiceApp extends StatelessWidget {
  const BintangServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bintang Service',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: warnaLatar,
        colorScheme: ColorScheme.fromSeed(
          seedColor: warnaEmas,
          brightness: Brightness.dark,
          primary: warnaEmas,
          surface: warnaKartu,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: warnaLatar,
          foregroundColor: warnaTeks,
          elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: warnaKartu,
          labelStyle: const TextStyle(color: warnaSekunder),
          hintStyle: const TextStyle(color: warnaSekunder),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: warnaGaris),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: warnaGaris),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: warnaEmas, width: 1.5),
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

// ============================================================
// WIDGET YANG DIGUNAKAN BERULANG
// ============================================================

class BrandHeader extends StatelessWidget {
  const BrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: warnaEmas,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.build_circle_outlined,
            color: warnaLatar,
            size: 30,
          ),
        ),
        const SizedBox(width: 12),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BINTANG SERVICE',
              style: TextStyle(
                color: warnaTeks,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.3,
              ),
            ),
            SizedBox(height: 3),
            Text(
              'BENGKEL MOTOR',
              style: TextStyle(
                color: warnaEmas,
                fontSize: 10,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String teks;
  final VoidCallback? onPressed;
  final IconData? ikon;

  const PrimaryButton({
    super.key,
    required this.teks,
    required this.onPressed,
    this.ikon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(ikon ?? Icons.arrow_forward),
        label: Text(
          teks,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: warnaEmas,
          foregroundColor: warnaLatar,
          disabledBackgroundColor: warnaGaris,
          disabledForegroundColor: warnaSekunder,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String judul;
  final String? subjudul;

  const SectionTitle({
    super.key,
    required this.judul,
    this.subjudul,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          judul,
          style: const TextStyle(
            color: warnaTeks,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (subjudul != null) ...[
          const SizedBox(height: 5),
          Text(
            subjudul!,
            style: const TextStyle(
              color: warnaSekunder,
              fontSize: 13,
            ),
          ),
        ],
      ],
    );
  }
}

// ============================================================
// HALAMAN 1: LOGIN
// ============================================================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController namaController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    super.dispose();
  }

  void masuk() {
    final String nama = namaController.text.trim();

    if (nama.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan masukkan nama pelanggan.'),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(namaPelanggan: nama),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BrandHeader(),
                  const SizedBox(height: 60),
                  const Text(
                    'Selamat Datang',
                    style: TextStyle(
                      color: warnaTeks,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Servis motor Anda dengan mudah di Bintang Service.',
                    style: TextStyle(
                      color: warnaSekunder,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Nama pelanggan',
                    style: TextStyle(color: warnaTeks),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: namaController,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan nama Anda',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    onSubmitted: (_) => masuk(),
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    teks: 'Masuk',
                    ikon: Icons.arrow_forward,
                    onPressed: masuk,
                  ),
                  const SizedBox(height: 28),
                  const Center(
                    child: Text(
                      'BINTANG SERVICE',
                      style: TextStyle(
                        color: warnaEmas,
                        letterSpacing: 3,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// HALAMAN 2: BERANDA
// ============================================================

class HomePage extends StatelessWidget {
  final String namaPelanggan;

  const HomePage({
    super.key,
    required this.namaPelanggan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BrandHeader(),
        toolbarHeight: 75,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Selamat datang, $namaPelanggan',
                    style: const TextStyle(
                      color: warnaEmas,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Servis Motor Anda di Sini.',
                    style: TextStyle(
                      color: warnaTeks,
                      fontSize: 34,
                      height: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Pilih pekerjaan yang Anda butuhkan. '
                    'Anda bisa memilih beberapa layanan dalam satu booking.',
                    style: TextStyle(
                      color: warnaSekunder,
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const SectionTitle(
                    judul: 'Layanan Bengkel',
                    subjudul: 'Pilih pekerjaan sesuai kebutuhan motor Anda.',
                  ),
                  const SizedBox(height: 18),
                  const ServiceCategoryCard(
                    ikon: Icons.oil_barrel_outlined,
                    judul: 'Oli dan Perawatan',
                    deskripsi: 'Pilih oli mesin dan oli gardan.',
                  ),
                  const SizedBox(height: 12),
                  const ServiceCategoryCard(
                    ikon: Icons.settings_outlined,
                    judul: 'Servis Mesin dan Injeksi',
                    deskripsi: 'Servis TB, CVT, injeksi, dan karburator.',
                  ),
                  const SizedBox(height: 12),
                  const ServiceCategoryCard(
                    ikon: Icons.tire_repair_outlined,
                    judul: 'Ban dan Kaki-kaki',
                    deskripsi: 'Ban, bearing roda, komstir, dan shock.',
                  ),
                  const SizedBox(height: 12),
                  const ServiceCategoryCard(
                    ikon: Icons.shield_outlined,
                    judul: 'Rem',
                    deskripsi: 'Kampas rem, minyak rem, dan kaliper.',
                  ),
                  const SizedBox(height: 28),
                  PrimaryButton(
                    teks: 'Pilih Servis',
                    ikon: Icons.checklist,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ServiceSelectionPage(
                            namaPelanggan: namaPelanggan,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Harga mengikuti katalog Bintang Service.',
                      style: TextStyle(
                        color: warnaSekunder,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ServiceCategoryCard extends StatelessWidget {
  final IconData ikon;
  final String judul;
  final String deskripsi;

  const ServiceCategoryCard({
    super.key,
    required this.ikon,
    required this.judul,
    required this.deskripsi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: warnaKartu,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: warnaGaris),
      ),
      child: Row(
        children: [
          Icon(ikon, color: warnaEmas, size: 30),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: const TextStyle(
                    color: warnaTeks,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  deskripsi,
                  style: const TextStyle(
                    color: warnaSekunder,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HALAMAN 3: PILIH LAYANAN
// ============================================================

class ServiceSelectionPage extends StatefulWidget {
  final String namaPelanggan;

  const ServiceSelectionPage({
    super.key,
    required this.namaPelanggan,
  });

  @override
  State<ServiceSelectionPage> createState() =>
      _ServiceSelectionPageState();
}

class _ServiceSelectionPageState extends State<ServiceSelectionPage> {
  final Set<String> layananTerpilih = {};
  String? oliTerpilih;

  int get totalHarga {
    int total = 0;

    for (final layanan in daftarLayanan) {
      if (layananTerpilih.contains(layanan.id)) {
        total += layanan.harga;
      }
    }

    if (oliTerpilih != null) {
      final oli = daftarOli.firstWhere(
        (item) => item.id == oliTerpilih,
      );
      total += oli.harga;
    }

    return total;
  }

  List<ServiceItem> get pilihanPelanggan {
    final List<ServiceItem> hasil = [];

    for (final layanan in daftarLayanan) {
      if (layananTerpilih.contains(layanan.id)) {
        hasil.add(layanan);
      }
    }

    if (oliTerpilih != null) {
      hasil.add(
        daftarOli.firstWhere(
          (item) => item.id == oliTerpilih,
        ),
      );
    }

    return hasil;
  }

  Widget buatJudulKategori(String judul, String deskripsi) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: SectionTitle(
        judul: judul,
        subjudul: deskripsi,
      ),
    );
  }

  Widget buatKartuLayanan(ServiceItem item) {
    final bool dipilih = layananTerpilih.contains(item.id);

    return InkWell(
      onTap: () {
        setState(() {
          if (dipilih) {
            layananTerpilih.remove(item.id);
          } else {
            layananTerpilih.add(item.id);
          }
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: dipilih ? const Color(0xFF302B20) : warnaKartu,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: dipilih ? warnaEmas : warnaGaris,
          ),
        ),
        child: Row(
          children: [
            Icon(
              dipilih
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: dipilih ? warnaEmas : warnaSekunder,
              size: 25,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.nama,
                    style: const TextStyle(
                      color: warnaTeks,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (item.keterangan.isNotEmpty) ...[
                    const SizedBox(height: 5),
                    Text(
                      item.keterangan,
                      style: const TextStyle(
                        color: warnaSekunder,
                        fontSize: 11,
                      ),
                    ),
                  ],
                  const SizedBox(height: 6),
                  Text(
                    rupiah(item.harga),
                    style: const TextStyle(
                      color: warnaEmas,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buatKartuOli(ServiceItem oli) {
    final bool dipilih = oliTerpilih == oli.id;

    return InkWell(
      onTap: () {
        setState(() {
          oliTerpilih = dipilih ? null : oli.id;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: dipilih ? const Color(0xFF302B20) : warnaKartu,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: dipilih ? warnaEmas : warnaGaris,
          ),
        ),
        child: Row(
          children: [
            Icon(
              dipilih
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: dipilih ? warnaEmas : warnaSekunder,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                oli.nama,
                style: const TextStyle(
                  color: warnaTeks,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              rupiah(oli.harga),
              style: const TextStyle(
                color: warnaEmas,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void lanjutBooking() {
    if (pilihanPelanggan.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih minimal satu pekerjaan atau produk.'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookingPage(
          namaPelanggan: widget.namaPelanggan,
          pilihan: pilihanPelanggan,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Pekerjaan'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
                children: [
                  const Text(
                    'Apa yang ingin diservis?',
                    style: TextStyle(
                      color: warnaTeks,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Centang semua pekerjaan yang dibutuhkan. '
                    'Untuk oli mesin, pilih satu merek.',
                    style: TextStyle(
                      color: warnaSekunder,
                      height: 1.5,
                    ),
                  ),

                  buatJudulKategori(
                    'Oli Mesin',
                    'Jasa ganti oli mesin gratis. Pilih satu jenis oli.',
                  ),
                  ...daftarOli.map(buatKartuOli),

                  buatJudulKategori(
                    'Servis Mesin dan Injeksi',
                    'Pilih satu atau beberapa pekerjaan.',
                  ),
                  ...daftarLayanan
                      .where(
                        (item) =>
                            item.kategori == 'Servis Mesin' ||
                            item.kategori == 'Servis Injeksi' ||
                            item.kategori == 'Mesin' ||
                            item.kategori == 'Karburator',
                      )
                      .map(buatKartuLayanan),

                  buatJudulKategori(
                    'Rem',
                    'Pekerjaan pada sistem pengereman.',
                  ),
                  ...daftarLayanan
                      .where((item) => item.kategori == 'Rem')
                      .map(buatKartuLayanan),

                  buatJudulKategori(
                    'Ban dan Roda',
                    'Ban tidak dijual oleh Bintang Service. '
                    'Harga pemasangan merupakan jasa.',
                  ),
                  ...daftarLayanan
                      .where(
                        (item) =>
                            item.kategori == 'Ban' ||
                            item.kategori == 'Roda',
                      )
                      .map(buatKartuLayanan),

                  buatJudulKategori(
                    'Kaki-kaki dan Layanan Lain',
                    'Pilih pekerjaan tambahan jika diperlukan.',
                  ),
                  ...daftarLayanan
                      .where(
                        (item) =>
                            item.kategori == 'Kaki-kaki' ||
                            item.kategori == 'Oli' ||
                            item.kategori == 'Produk' ||
                            item.kategori == 'Rantai',
                      )
                      .map(buatKartuLayanan),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
              decoration: const BoxDecoration(
                color: warnaKartu,
                border: Border(
                  top: BorderSide(color: warnaGaris),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pilihan Anda',
                              style: TextStyle(
                                color: warnaSekunder,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${pilihanPelanggan.length} item dipilih',
                              style: const TextStyle(
                                color: warnaTeks,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Total sementara',
                            style: TextStyle(
                              color: warnaSekunder,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            rupiah(totalHarga),
                            style: const TextStyle(
                              color: warnaEmas,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  PrimaryButton(
                    teks: 'Lanjut ke Booking',
                    ikon: Icons.calendar_month,
                    onPressed: lanjutBooking,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// HALAMAN 4: FORM BOOKING
// ============================================================

class BookingPage extends StatefulWidget {
  final String namaPelanggan;
  final List<ServiceItem> pilihan;

  const BookingPage({
    super.key,
    required this.namaPelanggan,
    required this.pilihan,
  });

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController namaController;
  final TextEditingController motorController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();

  DateTime? tanggalDipilih;
  String? jamDipilih;

  final List<String> pilihanJam = const [
    '09.00',
    '10.00',
    '11.00',
    '13.00',
    '14.00',
    '15.00',
    '16.00',
  ];

  int get totalHarga {
    return widget.pilihan.fold(
      0,
      (total, item) => total + item.harga,
    );
  }

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(
      text: widget.namaPelanggan,
    );
  }

  @override
  void dispose() {
    namaController.dispose();
    motorController.dispose();
    catatanController.dispose();
    super.dispose();
  }

  Future<void> pilihTanggal() async {
    final DateTime sekarang = DateTime.now();

    final DateTime? hasil = await showDatePicker(
      context: context,
      initialDate: tanggalDipilih ?? sekarang,
      firstDate: DateTime(
        sekarang.year,
        sekarang.month,
        sekarang.day,
      ),
      lastDate: DateTime.now().add(
        const Duration(days: 90),
      ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: warnaEmas,
              onPrimary: warnaLatar,
              surface: warnaKartu,
              onSurface: warnaTeks,
            ),
          ),
          child: child!,
        );
      },
    );

    if (hasil != null && mounted) {
      setState(() {
        tanggalDipilih = hasil;
      });
    }
  }

  String tanggalIndonesia(DateTime tanggal) {
    const List<String> namaBulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return '${tanggal.day} ${namaBulan[tanggal.month - 1]} '
        '${tanggal.year}';
  }

  void konfirmasiBooking() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (tanggalDipilih == null || jamDipilih == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih tanggal dan jam booking.'),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => SuccessPage(
          namaPelanggan: namaController.text.trim(),
          jenisMotor: motorController.text.trim(),
          tanggal: tanggalIndonesia(tanggalDipilih!),
          jam: jamDipilih!,
          catatan: catatanController.text.trim(),
          pilihan: widget.pilihan,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Booking'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SectionTitle(
                judul: 'Data Booking',
                subjudul: 'Lengkapi data untuk melanjutkan pemesanan.',
              ),
              const SizedBox(height: 22),

              const Text(
                'Nama pelanggan',
                style: TextStyle(color: warnaTeks),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(
                  hintText: 'Nama pelanggan',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama wajib diisi.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 18),
              const Text(
                'Jenis motor',
                style: TextStyle(color: warnaTeks),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: motorController,
                decoration: const InputDecoration(
                  hintText: 'Contoh: Honda Beat 2024',
                  prefixIcon: Icon(Icons.two_wheeler),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Jenis motor wajib diisi.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 18),
              const Text(
                'Tanggal servis',
                style: TextStyle(color: warnaTeks),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: pilihTanggal,
                icon: const Icon(Icons.calendar_month),
                label: Text(
                  tanggalDipilih == null
                      ? 'Pilih tanggal'
                      : tanggalIndonesia(tanggalDipilih!),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: warnaEmas,
                  minimumSize: const Size.fromHeight(50),
                  side: const BorderSide(color: warnaGaris),
                ),
              ),

              const SizedBox(height: 18),
              const Text(
                'Jam servis',
                style: TextStyle(color: warnaTeks),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: jamDipilih,
                decoration: const InputDecoration(
                  hintText: 'Pilih jam servis',
                  prefixIcon: Icon(Icons.access_time),
                ),
                items: pilihanJam.map((jam) {
                  return DropdownMenuItem(
                    value: jam,
                    child: Text('$jam WIB'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    jamDipilih = value;
                  });
                },
              ),

              const SizedBox(height: 18),
              const Text(
                'Catatan tambahan (opsional)',
                style: TextStyle(color: warnaTeks),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: catatanController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Keluhan atau catatan untuk mekanik',
                  alignLabelWithHint: true,
                ),
              ),

              const SizedBox(height: 26),
              const SectionTitle(
                judul: 'Ringkasan Pekerjaan',
              ),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: warnaKartu,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: warnaGaris),
                ),
                child: Column(
                  children: [
                    ...widget.pilihan.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                item.nama,
                                style: const TextStyle(
                                  color: warnaTeks,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              rupiah(item.harga),
                              style: const TextStyle(
                                color: warnaEmas,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(color: warnaGaris),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'TOTAL',
                            style: TextStyle(
                              color: warnaTeks,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          rupiah(totalHarga),
                          style: const TextStyle(
                            color: warnaEmas,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              PrimaryButton(
                teks: 'Konfirmasi Booking',
                ikon: Icons.check_circle_outline,
                onPressed: konfirmasiBooking,
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// HALAMAN 5: BOOKING BERHASIL
// ============================================================

class SuccessPage extends StatelessWidget {
  final String namaPelanggan;
  final String jenisMotor;
  final String tanggal;
  final String jam;
  final String catatan;
  final List<ServiceItem> pilihan;

  const SuccessPage({
    super.key,
    required this.namaPelanggan,
    required this.jenisMotor,
    required this.tanggal,
    required this.jam,
    required this.catatan,
    required this.pilihan,
  });

  int get totalHarga {
    return pilihan.fold(
      0,
      (total, item) => total + item.harga,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BrandHeader(),
        toolbarHeight: 75,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                children: [
                  Container(
                    width: 82,
                    height: 82,
                    decoration: BoxDecoration(
                      color: warnaEmas.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: warnaEmas,
                      size: 54,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Booking Berhasil!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: warnaTeks,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Terima kasih telah memilih Bintang Service.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: warnaSekunder,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 28),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: warnaKartu,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: warnaGaris),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'RINGKASAN BOOKING',
                          style: TextStyle(
                            color: warnaEmas,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 18),

                        SummaryRow(
                          label: 'Nama',
                          value: namaPelanggan,
                        ),
                        SummaryRow(
                          label: 'Jenis motor',
                          value: jenisMotor,
                        ),
                        SummaryRow(
                          label: 'Tanggal',
                          value: tanggal,
                        ),
                        SummaryRow(
                          label: 'Jam',
                          value: '$jam WIB',
                        ),

                        const Divider(
                          height: 30,
                          color: warnaGaris,
                        ),

                        const Text(
                          'Pekerjaan dipilih',
                          style: TextStyle(
                            color: warnaTeks,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),

                        ...pilihan.map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.check,
                                  size: 18,
                                  color: warnaEmas,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    item.nama,
                                    style: const TextStyle(
                                      color: warnaTeks,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  rupiah(item.harga),
                                  style: const TextStyle(
                                    color: warnaEmas,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        if (catatan.isNotEmpty) ...[
                          const Divider(color: warnaGaris),
                          const Text(
                            'Catatan',
                            style: TextStyle(
                              color: warnaSekunder,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            catatan,
                            style: const TextStyle(
                              color: warnaTeks,
                            ),
                          ),
                        ],

                        const Divider(
                          height: 30,
                          color: warnaGaris,
                        ),

                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'TOTAL BIAYA',
                                style: TextStyle(
                                  color: warnaTeks,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              rupiah(totalHarga),
                              style: const TextStyle(
                                color: warnaEmas,
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  PrimaryButton(
                    teks: 'Kembali ke Beranda',
                    ikon: Icons.home_outlined,
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HomePage(
                            namaPelanggan: namaPelanggan,
                          ),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Bintang Service',
                    style: TextStyle(
                      color: warnaEmas,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 105,
            child: Text(
              label,
              style: const TextStyle(
                color: warnaSekunder,
              ),
            ),
          ),
          const Text(
            ': ',
            style: TextStyle(color: warnaSekunder),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: warnaTeks,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
