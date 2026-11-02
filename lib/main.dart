
import 'package:flutter/material.dart';
import 'services/api_service.dart';

void main() {
  runApp(const BintangServiceApp());
}

// ============================================================
// TEMA DAN WARNA
// ============================================================

const Color warnaLatar = Color(0xFF0B0B0B);
const Color warnaKartu = Color(0xFF171717);
const Color warnaKartu2 = Color(0xFF202020);
const Color warnaEmas = Color(0xFFD6B56D);
const Color warnaEmasTerang = Color(0xFFF0D99A);
const Color warnaPutih = Color(0xFFF5F2EA);
const Color warnaAbu = Color(0xFFA5A5A5);
const Color warnaHijau = Color(0xFF65C18C);
const Color warnaMerah = Color(0xFFE57373);

const double radiusKartu = 16;

// ============================================================
// FORMAT RUPIAH
// ============================================================

String formatRupiah(int angka) {
  final hasil = angka.toString();
  final buffer = StringBuffer();

  for (int i = 0; i < hasil.length; i++) {
    buffer.write(hasil[i]);

    final sisa = hasil.length - i - 1;
    if (sisa > 0 && sisa % 3 == 0) {
      buffer.write('.');
    }
  }

  return 'Rp${buffer.toString()}';
}

// ============================================================
// MODEL LAYANAN
// ============================================================

class ServiceItem {
  final String id;
  final int? databaseId;
  final String nama;
  final String kategori;
  final int harga;
  final String keterangan;

  const ServiceItem({
    required this.id,
    this.databaseId,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.keterangan,
  });

  factory ServiceItem.fromJson(Map<String, dynamic> json) {
    final hargaMentah = json['price']?.toString() ?? '0';

    return ServiceItem(
      id: json['code']?.toString() ?? '',
      databaseId: int.tryParse(json['id'].toString()),
      nama: json['service_name']?.toString() ?? 'Layanan',
      kategori: json['category']?.toString() ?? 'Lainnya',
      harga: (double.tryParse(hargaMentah) ?? 0).round(),
      keterangan: json['description']?.toString() ?? '',
    );
  }
}

// ============================================================
// APLIKASI UTAMA
// ============================================================

class BintangServiceApp extends StatelessWidget {
  const BintangServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bintang Service',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: warnaLatar,
        primaryColor: warnaEmas,
        fontFamily: 'Arial',
        colorScheme: const ColorScheme.dark(
          primary: warnaEmas,
          secondary: warnaEmasTerang,
          surface: warnaKartu,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: warnaLatar,
          foregroundColor: warnaPutih,
          elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: warnaKartu2,
          labelStyle: const TextStyle(color: warnaAbu),
          hintStyle: const TextStyle(color: warnaAbu),
          prefixIconColor: warnaEmas,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 17,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: Colors.white12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: Colors.white12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(
              color: warnaEmas,
              width: 1.4,
            ),
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

// ============================================================
// KOMPONEN BRAND
// ============================================================

class BrandHeader extends StatelessWidget {
  final bool kecil;

  const BrandHeader({
    super.key,
    this.kecil = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: kecil ? 42 : 50,
          height: kecil ? 42 : 50,
          decoration: BoxDecoration(
            border: Border.all(color: warnaEmas, width: 1.4),
            borderRadius: BorderRadius.circular(13),
            color: warnaEmas.withValues(alpha: 0.06),
          ),
          child: Icon(
            Icons.two_wheeler,
            color: warnaEmas,
            size: kecil ? 23 : 28,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BINTANG SERVICE',
              style: TextStyle(
                color: warnaEmas,
                fontSize: kecil ? 15 : 17,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.4,
              ),
            ),
            const SizedBox(height: 3),
            const Text(
              'MOTORCYCLE SERVICE',
              style: TextStyle(
                color: warnaAbu,
                fontSize: 9,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ============================================================
// KOMPONEN TOMBOL
// ============================================================

class PrimaryButton extends StatelessWidget {
  final String teks;
  final VoidCallback? onPressed;
  final bool loading;
  final IconData? icon;

  const PrimaryButton({
    super.key,
    required this.teks,
    required this.onPressed,
    this.loading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 53,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: warnaEmas,
          foregroundColor: Colors.black,
          disabledBackgroundColor: warnaEmas.withValues(alpha: 0.45),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: loading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.black,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 19),
                    const SizedBox(width: 9),
                  ],
                  Text(
                    teks,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

// ============================================================
// KOMPONEN JUDUL BAGIAN
// ============================================================

class SectionTitle extends StatelessWidget {
  final String teks;
  final String? subjudul;

  const SectionTitle(
    this.teks, {
    super.key,
    this.subjudul,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            teks,
            style: const TextStyle(
              color: warnaEmas,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
          ),
          if (subjudul != null) ...[
            const SizedBox(height: 5),
            Text(
              subjudul!,
              style: const TextStyle(
                color: warnaAbu,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ============================================================
// KOMPONEN KARTU INFORMASI
// ============================================================

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String judul;
  final String deskripsi;

  const InfoCard({
    super.key,
    required this.icon,
    required this.judul,
    required this.deskripsi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: warnaKartu,
        borderRadius: BorderRadius.circular(radiusKartu),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: warnaEmas.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: warnaEmas),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: const TextStyle(
                    color: warnaPutih,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  deskripsi,
                  style: const TextStyle(
                    color: warnaAbu,
                    fontSize: 12,
                    height: 1.4,
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
// HALAMAN LOGIN
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
    final nama = namaController.text.trim();

    if (nama.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan nama pelanggan terlebih dahulu'),
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
              constraints: const BoxConstraints(maxWidth: 470),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BrandHeader(),
                  const SizedBox(height: 55),
                  Container(
                    padding: const EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      color: warnaEmas.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: warnaEmas.withValues(alpha: 0.25),
                      ),
                    ),
                    child: const Icon(
                      Icons.two_wheeler,
                      color: warnaEmas,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'Selamat Datang',
                    style: TextStyle(
                      color: warnaPutih,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Servis Motor Anda di Sini.',
                    style: TextStyle(
                      color: warnaEmas,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Masuk menggunakan nama Anda untuk mulai memilih layanan dan membuat pemesanan servis motor.',
                    style: TextStyle(
                      color: warnaAbu,
                      height: 1.6,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const SectionTitle('Identitas Pelanggan'),
                  TextField(
                    controller: namaController,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: 'Nama pelanggan',
                      hintText: 'Masukkan nama lengkap',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    onSubmitted: (_) => masuk(),
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    teks: 'MASUK KE APLIKASI',
                    icon: Icons.arrow_forward,
                    onPressed: masuk,
                  ),
                  const SizedBox(height: 28),
                  const Center(
                    child: Text(
                      'BINTANG SERVICE  •  MOTORCYCLE CARE',
                      style: TextStyle(
                        color: warnaAbu,
                        fontSize: 9,
                        letterSpacing: 1.4,
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
// HALAMAN BERANDA
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
        automaticallyImplyLeading: false,
        title: const BrandHeader(kecil: true),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Text(
                    'SELAMAT DATANG',
                    style: TextStyle(
                      color: warnaEmas.withValues(alpha: 0.85),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Halo, $namaPelanggan',
                    style: const TextStyle(
                      color: warnaPutih,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(23),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF292318),
                          Color(0xFF171717),
                          Color(0xFF111111),
                        ],
                      ),
                      border: Border.all(
                        color: warnaEmas.withValues(alpha: 0.45),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.workspace_premium_outlined,
                              color: warnaEmas,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'BINTANG SERVICE',
                              style: TextStyle(
                                color: warnaEmas,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          'Servis Motor\nAnda di Sini.',
                          style: TextStyle(
                            color: warnaPutih,
                            fontSize: 33,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Pilih kebutuhan perawatan dan perbaikan motor Anda dengan mudah melalui sistem pemesanan Bintang Service.',
                          style: TextStyle(
                            color: warnaAbu,
                            height: 1.6,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Container(
                          height: 1,
                          color: warnaEmas.withValues(alpha: 0.25),
                        ),
                        const SizedBox(height: 15),
                        const Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              color: warnaEmas,
                              size: 17,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Pilih beberapa layanan dalam satu booking',
                                style: TextStyle(
                                  color: warnaPutih,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const SectionTitle(
                    'Layanan Bintang Service',
                    subjudul: 'Kemudahan pemesanan servis motor Anda',
                  ),
                  const InfoCard(
                    icon: Icons.build_outlined,
                    judul: 'Layanan Servis',
                    deskripsi:
                        'Pilih jasa perawatan dan perbaikan sesuai kebutuhan motor.',
                  ),
                  const SizedBox(height: 11),
                  const InfoCard(
                    icon: Icons.oil_barrel_outlined,
                    judul: 'Produk Oli',
                    deskripsi:
                        'Pilih produk oli mesin dan Oli Gear secara terpisah.',
                  ),
                  const SizedBox(height: 11),
                  const InfoCard(
                    icon: Icons.calendar_month_outlined,
                    judul: 'Jadwal Servis',
                    deskripsi:
                        'Tentukan tanggal dan jam kedatangan untuk servis.',
                  ),
                  const SizedBox(height: 27),
                  PrimaryButton(
                    teks: 'MULAI PEMESANAN',
                    icon: Icons.arrow_forward,
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
                  const SizedBox(height: 25),
                  const Center(
                    child: Text(
                      'BINTANG SERVICE',
                      style: TextStyle(
                        color: warnaAbu,
                        fontSize: 10,
                        letterSpacing: 2,
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
// HALAMAN PEMILIHAN LAYANAN
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
  List<ServiceItem> semuaLayanan = [];
  final Set<int> layananTerpilih = {};

  bool sedangMemuat = true;
  String? pesanError;

  @override
  void initState() {
    super.initState();
    muatKatalog();
  }

  Future<void> muatKatalog() async {
    setState(() {
      sedangMemuat = true;
      pesanError = null;
    });

    try {
      final data = await ApiService.getServices();

      final hasil = data.map((item) {
        return ServiceItem.fromJson(
          Map<String, dynamic>.from(item),
        );
      }).toList();

      if (!mounted) return;

      setState(() {
        semuaLayanan = hasil;
        sedangMemuat = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        pesanError = e.toString();
        sedangMemuat = false;
      });
    }
  }

  // Oli Gear TIDAK termasuk kelompok Oli Mesin.
  // Kategori "Oli" dan "Oli Mesin" dikenali sebagai Oli Mesin.
  bool adalahOliMesin(ServiceItem item) {
    final kategori = item.kategori.trim().toLowerCase();
    return kategori == 'oli mesin' || kategori == 'oli';
  }

  int get totalHarga {
    int total = 0;

    for (final item in semuaLayanan) {
      if (item.databaseId != null &&
          layananTerpilih.contains(item.databaseId)) {
        total += item.harga;
      }
    }

    return total;
  }

  List<ServiceItem> get layananDipilih {
    return semuaLayanan.where((item) {
      return item.databaseId != null &&
          layananTerpilih.contains(item.databaseId);
    }).toList();
  }

  void ubahPilihan(ServiceItem item, bool dipilih) {
    final id = item.databaseId;
    if (id == null) return;

    setState(() {
      if (dipilih) {
        // Hanya produk Oli Mesin yang saling menggantikan.
        // Oli Gear dapat dipilih bersamaan dengan Oli Mesin.
        if (adalahOliMesin(item)) {
          for (final oli in semuaLayanan.where(adalahOliMesin)) {
            if (oli.databaseId != null) {
              layananTerpilih.remove(oli.databaseId);
            }
          }
        }

        layananTerpilih.add(id);
      } else {
        layananTerpilih.remove(id);
      }
    });
  }

  List<String> get kategoriLayanan {
    final hasil = <String>[];

    for (final item in semuaLayanan) {
      if (!hasil.contains(item.kategori)) {
        hasil.add(item.kategori);
      }
    }

    hasil.sort((a, b) {
      int urutan(String kategori) {
        final k = kategori.trim().toLowerCase();

        if (k == 'oli mesin' || k == 'oli') return 0;
        if (k == 'oli gear') return 1;

        return 2;
      }

      final perbandingan = urutan(a).compareTo(urutan(b));

      if (perbandingan != 0) {
        return perbandingan;
      }

      return a.compareTo(b);
    });

    return hasil;
  }

  IconData ikonKategori(String kategori) {
    final k = kategori.toLowerCase();

    if (k.contains('oli')) return Icons.oil_barrel_outlined;
    if (k.contains('ban')) return Icons.tire_repair;
    if (k.contains('rem')) return Icons.settings;
    if (k.contains('mesin')) return Icons.settings_suggest;
    if (k.contains('cvt')) return Icons.settings;
    if (k.contains('aki')) return Icons.battery_charging_full;
    if (k.contains('shock')) return Icons.tune;
    if (k.contains('karburator')) return Icons.build;
    if (k.contains('bearing')) return Icons.album_outlined;

    return Icons.handyman_outlined;
  }

  Widget kartuLayanan(ServiceItem item) {
    final id = item.databaseId;
    final terpilih = id != null && layananTerpilih.contains(id);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => ubahPilihan(item, !terpilih),
        borderRadius: BorderRadius.circular(13),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: terpilih
                ? warnaEmas.withValues(alpha: 0.09)
                : warnaKartu,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: terpilih ? warnaEmas : Colors.white10,
              width: terpilih ? 1.3 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                terpilih
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: terpilih ? warnaEmas : warnaAbu,
                size: 23,
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.nama,
                      style: TextStyle(
                        color: warnaPutih,
                        fontWeight: terpilih
                            ? FontWeight.bold
                            : FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    if (item.keterangan.isNotEmpty) ...[
                      const SizedBox(height: 5),
                      Text(
                        item.keterangan,
                        style: const TextStyle(
                          color: warnaAbu,
                          fontSize: 11,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 9),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formatRupiah(item.harga),
                    style: const TextStyle(
                      color: warnaEmas,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    terpilih ? 'Dipilih' : 'Pilih',
                    style: TextStyle(
                      color: terpilih ? warnaEmas : warnaAbu,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bagianKategori(String kategori) {
    final daftar = semuaLayanan
        .where((item) => item.kategori == kategori)
        .toList();

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: warnaEmas.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  ikonKategori(kategori),
                  color: warnaEmas,
                  size: 20,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Text(
                  kategori,
                  style: const TextStyle(
                    color: warnaEmas,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Text(
                '${daftar.length} pilihan',
                style: const TextStyle(
                  color: warnaAbu,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ...daftar.map(kartuLayanan),
        ],
      ),
    );
  }

  void lanjutBooking() {
    if (layananDipilih.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih minimal satu layanan terlebih dahulu'),
        ),
      );
      return;
    }

    if (layananDipilih.any((item) => item.databaseId == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ada layanan yang belum memiliki ID database'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookingPage(
          namaPelanggan: widget.namaPelanggan,
          layananDipilih: layananDipilih,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Katalog Layanan',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: sedangMemuat
          ? const Center(
              child: CircularProgressIndicator(color: warnaEmas),
            )
          : pesanError != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.cloud_off_outlined,
                          color: warnaMerah,
                          size: 48,
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Katalog belum dapat dimuat',
                          style: TextStyle(
                            color: warnaPutih,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          pesanError!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: warnaAbu,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 20),
                        PrimaryButton(
                          teks: 'COBA LAGI',
                          onPressed: muatKatalog,
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: RefreshIndicator(
                        color: warnaEmas,
                        backgroundColor: warnaKartu,
                        onRefresh: muatKatalog,
                        child: ListView(
                          padding: const EdgeInsets.all(17),
                          children: [
                            const Text(
                              'PILIH KEBUTUHAN MOTOR',
                              style: TextStyle(
                                color: warnaEmas,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Pilih satu atau beberapa layanan yang Anda butuhkan.',
                              style: TextStyle(
                                color: warnaAbu,
                                fontSize: 12,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 18),
                            Container(
                              padding: const EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                color: warnaEmas.withValues(alpha: 0.07),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: warnaEmas.withValues(alpha: 0.2),
                                ),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: warnaEmas,
                                    size: 19,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Oli Mesin dan Oli Gear merupakan pilihan terpisah.',
                                      style: TextStyle(
                                        color: warnaPutih,
                                        fontSize: 11,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (semuaLayanan.isEmpty)
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(25),
                                  child: Text(
                                    'Belum ada layanan tersedia.',
                                    style: TextStyle(color: warnaAbu),
                                  ),
                                ),
                              ),
                            ...kategoriLayanan.map(bagianKategori),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(18, 15, 18, 18),
                      decoration: const BoxDecoration(
                        color: warnaKartu,
                        border: Border(
                          top: BorderSide(color: Colors.white12),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'TOTAL PILIHAN',
                                    style: TextStyle(
                                      color: warnaAbu,
                                      fontSize: 10,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${layananTerpilih.length} layanan dipilih',
                                    style: const TextStyle(
                                      color: warnaPutih,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'TOTAL HARGA',
                                    style: TextStyle(
                                      color: warnaAbu,
                                      fontSize: 10,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    formatRupiah(totalHarga),
                                    style: const TextStyle(
                                      color: warnaEmas,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          PrimaryButton(
                            teks: 'LANJUTKAN PEMESANAN',
                            icon: Icons.arrow_forward,
                            onPressed: lanjutBooking,
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
// HALAMAN FORM PEMESANAN
// ============================================================

class BookingPage extends StatefulWidget {
  final String namaPelanggan;
  final List<ServiceItem> layananDipilih;

  const BookingPage({
    super.key,
    required this.namaPelanggan,
    required this.layananDipilih,
  });

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final formKey = GlobalKey<FormState>();

  final nomorHpController = TextEditingController();
  final nomorPolisiController = TextEditingController();

  String jenisMotor = 'Honda Beat';
  DateTime? tanggalBooking;
  String jamBooking = '09:00';

  bool sedangMengirim = false;

  final List<String> daftarMotor = [
    'Honda Beat',
    'Honda Vario',
    'Honda Scoopy',
    'Honda PCX',
    'Honda Supra',
    'Honda Revo',
    'Yamaha Mio',
    'Yamaha NMAX',
    'Yamaha Aerox',
    'Yamaha Fazzio',
    'Yamaha Jupiter',
    'Suzuki',
    'Kawasaki',
    'Lainnya',
  ];

  final List<String> daftarJam = [
    '09:00',
    '10:00',
    '11:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
  ];

  @override
  void dispose() {
    nomorHpController.dispose();
    nomorPolisiController.dispose();
    super.dispose();
  }

  int get totalHarga {
    return widget.layananDipilih.fold(
      0,
      (total, item) => total + item.harga,
    );
  }

  Future<void> pilihTanggal() async {
    final sekarang = DateTime.now();

    final hasil = await showDatePicker(
      context: context,
      initialDate: tanggalBooking ?? sekarang,
      firstDate: DateTime(
        sekarang.year,
        sekarang.month,
        sekarang.day,
      ),
      lastDate: sekarang.add(const Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: warnaEmas,
              onPrimary: Colors.black,
              surface: warnaKartu,
              onSurface: warnaPutih,
            ),
          ),
          child: child!,
        );
      },
    );

    if (hasil != null) {
      setState(() {
        tanggalBooking = hasil;
      });
    }
  }

  String tanggalUntukDatabase(DateTime tanggal) {
    final tahun = tanggal.year.toString().padLeft(4, '0');
    final bulan = tanggal.month.toString().padLeft(2, '0');
    final hari = tanggal.day.toString().padLeft(2, '0');

    return '$tahun-$bulan-$hari';
  }

  String jamUntukDatabase(String jam) {
    return '$jam:00';
  }

  Future<void> konfirmasiBooking() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (tanggalBooking == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih tanggal booking terlebih dahulu'),
        ),
      );
      return;
    }

    final serviceIds = widget.layananDipilih
        .map((item) => item.databaseId!)
        .toList();

    setState(() {
      sedangMengirim = true;
    });

    try {
      final hasil = await ApiService.createBooking(
        name: widget.namaPelanggan,
        phone: nomorHpController.text.trim(),
        bookingDate: tanggalUntukDatabase(tanggalBooking!),
        bookingTime: jamUntukDatabase(jamBooking),
        motorcycleType: jenisMotor,
        motorcycleNumber: nomorPolisiController.text.trim().toUpperCase(),
        serviceIds: serviceIds,
      );

      if (!mounted) return;

      final bookingId = hasil['booking_id']?.toString() ?? '-';

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => SuccessPage(
            namaPelanggan: widget.namaPelanggan,
            bookingId: bookingId,
            totalHarga: totalHarga,
            tanggal: tanggalUntukDatabase(tanggalBooking!),
            jam: jamBooking,
            layananDipilih: widget.layananDipilih,
          ),
        ),
        (route) => route.isFirst,
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Booking gagal: $e'),
          duration: const Duration(seconds: 5),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          sedangMengirim = false;
        });
      }
    }
  }

  Widget kartuForm({
    required String judul,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 23),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: warnaKartu,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(judul),
          ...children,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form Pemesanan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            const Text(
              'LENGKAPI DATA PEMESANAN',
              style: TextStyle(
                color: warnaEmas,
                fontSize: 11,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              'Pastikan informasi pelanggan dan kendaraan sudah benar.',
              style: TextStyle(
                color: warnaAbu,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 20),

            kartuForm(
              judul: 'Data Pelanggan',
              children: [
                TextFormField(
                  initialValue: widget.namaPelanggan,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Nama pelanggan',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 13),
                TextFormField(
                  controller: nomorHpController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Nomor HP / WhatsApp',
                    hintText: 'Contoh: 081234567890',
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nomor HP wajib diisi';
                    }
                    if (value.trim().length < 9) {
                      return 'Nomor HP tidak valid';
                    }
                    return null;
                  },
                ),
              ],
            ),

            kartuForm(
              judul: 'Data Kendaraan',
              children: [
                DropdownButtonFormField<String>(
                  initialValue: jenisMotor,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Jenis motor',
                    prefixIcon: Icon(Icons.two_wheeler),
                  ),
                  dropdownColor: warnaKartu2,
                  items: daftarMotor.map((motor) {
                    return DropdownMenuItem(
                      value: motor,
                      child: Text(motor),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        jenisMotor = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 13),
                TextFormField(
                  controller: nomorPolisiController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                    labelText: 'Nomor polisi',
                    hintText: 'Contoh: BL 1234 AB',
                    prefixIcon: Icon(
                      Icons.confirmation_number_outlined,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nomor polisi wajib diisi';
                    }
                    return null;
                  },
                ),
              ],
            ),

            kartuForm(
              judul: 'Jadwal Servis',
              children: [
                InkWell(
                  onTap: pilihTanggal,
                  borderRadius: BorderRadius.circular(13),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: warnaKartu2,
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_outlined,
                          color: warnaEmas,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            tanggalBooking == null
                                ? 'Pilih tanggal servis'
                                : tanggalUntukDatabase(tanggalBooking!),
                            style: const TextStyle(
                              color: warnaPutih,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: warnaAbu,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 13),
                DropdownButtonFormField<String>(
                  initialValue: jamBooking,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Jam servis',
                    prefixIcon: Icon(Icons.access_time),
                  ),
                  dropdownColor: warnaKartu2,
                  items: daftarJam.map((jam) {
                    return DropdownMenuItem(
                      value: jam,
                      child: Text(jam),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        jamBooking = value;
                      });
                    }
                  },
                ),
              ],
            ),

            kartuForm(
              judul: 'Ringkasan Pesanan',
              children: [
                ...widget.layananDipilih.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 13),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: warnaEmas,
                          size: 17,
                        ),
                        const SizedBox(width: 9),
                        Expanded(
                          child: Text(
                            item.nama,
                            style: const TextStyle(
                              color: warnaPutih,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          formatRupiah(item.harga),
                          style: const TextStyle(
                            color: warnaEmas,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const Divider(color: Colors.white24, height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total pembayaran',
                      style: TextStyle(
                        color: warnaPutih,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      formatRupiah(totalHarga),
                      style: const TextStyle(
                        color: warnaEmas,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            PrimaryButton(
              teks: 'KONFIRMASI PEMESANAN',
              icon: Icons.check_circle_outline,
              loading: sedangMengirim,
              onPressed: konfirmasiBooking,
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// HALAMAN BOOKING BERHASIL
// ============================================================

class SuccessPage extends StatelessWidget {
  final String namaPelanggan;
  final String bookingId;
  final int totalHarga;
  final String tanggal;
  final String jam;
  final List<ServiceItem> layananDipilih;

  const SuccessPage({
    super.key,
    required this.namaPelanggan,
    required this.bookingId,
    required this.totalHarga,
    required this.tanggal,
    required this.jam,
    required this.layananDipilih,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking Berhasil',
          style: TextStyle(fontSize: 17),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(
                children: [
                  Container(
                    width: 95,
                    height: 95,
                    decoration: BoxDecoration(
                      color: warnaHijau.withValues(alpha: 0.10),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: warnaHijau.withValues(alpha: 0.35),
                      ),
                    ),
                    child: const Icon(
                      Icons.check_circle_outline,
                      color: warnaHijau,
                      size: 58,
                    ),
                  ),
                  const SizedBox(height: 23),
                  const Text(
                    'Pemesanan Berhasil!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: warnaPutih,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Terima kasih, $namaPelanggan. Data pemesanan Anda berhasil dikirim.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: warnaAbu,
                      height: 1.6,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: warnaKartu,
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(
                        color: warnaEmas.withValues(alpha: 0.55),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BrandHeader(kecil: true),
                        const SizedBox(height: 22),
                        const Text(
                          'DETAIL PEMESANAN',
                          style: TextStyle(
                            color: warnaEmas,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 18),
                        SummaryRow(
                          label: 'Nomor booking',
                          value: '#$bookingId',
                        ),
                        SummaryRow(
                          label: 'Nama pelanggan',
                          value: namaPelanggan,
                        ),
                        SummaryRow(
                          label: 'Tanggal servis',
                          value: tanggal,
                        ),
                        SummaryRow(
                          label: 'Jam servis',
                          value: jam,
                        ),
                        const Divider(
                          color: Colors.white24,
                          height: 28,
                        ),
                        const Text(
                          'LAYANAN YANG DIPILIH',
                          style: TextStyle(
                            color: warnaEmas,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 14),
                        ...layananDipilih.map((item) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: SummaryRow(
                              label: item.nama,
                              value: formatRupiah(item.harga),
                            ),
                          );
                        }),
                        const Divider(
                          color: Colors.white24,
                          height: 25,
                        ),
                        SummaryRow(
                          label: 'TOTAL PEMBAYARAN',
                          value: formatRupiah(totalHarga),
                          bold: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  PrimaryButton(
                    teks: 'KEMBALI KE BERANDA',
                    icon: Icons.home_outlined,
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
                  const SizedBox(height: 20),
                  const Text(
                    'TERIMA KASIH TELAH MEMILIH BINTANG SERVICE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: warnaAbu,
                      fontSize: 9,
                      letterSpacing: 1,
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
// KOMPONEN BARIS RINGKASAN
// ============================================================

class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: bold ? warnaPutih : warnaAbu,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: bold ? warnaEmas : warnaPutih,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                fontSize: bold ? 15 : 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
