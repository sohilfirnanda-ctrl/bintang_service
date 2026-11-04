
import 'package:flutter/material.dart';
import 'services/api_service.dart';

void main() {
  runApp(const BintangServiceApp());
}

// ============================================================
// TEMA
// ============================================================

const Color warnaLatar = Color(0xFF0B0B0B);
const Color warnaKartu = Color(0xFF171717);
const Color warnaKartu2 = Color(0xFF202020);
const Color warnaEmas = Color(0xFFD6B36A);
const Color warnaPutih = Color(0xFFF5F5F5);
const Color warnaAbu = Color(0xFFAAAAAA);
const Color warnaHijau = Color(0xFF55B879);

String formatRupiah(int angka) {
  final text = angka.toString();
  final buffer = StringBuffer();

  for (int i = 0; i < text.length; i++) {
    buffer.write(text[i]);

    final sisa = text.length - i - 1;

    if (sisa > 0 && sisa % 3 == 0) {
      buffer.write('.');
    }
  }

  return 'Rp${buffer.toString()}';
}

// ============================================================
// APLIKASI
// ============================================================

class BintangServiceApp extends StatelessWidget {
  const BintangServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bintang Service',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: warnaLatar,
        colorScheme: const ColorScheme.dark(
          primary: warnaEmas,
          secondary: warnaEmas,
          surface: warnaKartu,
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
        ),
      ),
      home: const LoginPage(),
    );
  }
}

// ============================================================
// TOMBOL UTAMA
// ============================================================

class TombolUtama extends StatelessWidget {
  final String teks;
  final VoidCallback? onPressed;

  const TombolUtama({
    super.key,
    required this.teks,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: warnaEmas,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          teks,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// LOGIN
// ============================================================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final namaController = TextEditingController();
  final teleponController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    teleponController.dispose();
    super.dispose();
  }

  void masuk() {
    final nama = namaController.text.trim();
    final telepon = teleponController.text.trim();

    if (nama.isEmpty || telepon.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama dan nomor telepon harus diisi.'),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(
          nama: nama,
          telepon: telepon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Icon(
                    Icons.two_wheeler,
                    color: warnaEmas,
                    size: 70,
                  ),
                ),
                const SizedBox(height: 24),
                const Center(
                  child: Text(
                    'BINTANG SERVICE',
                    style: TextStyle(
                      color: warnaEmas,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Center(
                  child: Text(
                    'Booking servis motor dengan mudah.',
                    style: TextStyle(color: warnaAbu),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Masuk Pelanggan',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: namaController,
                  decoration: const InputDecoration(
                    labelText: 'Nama pelanggan',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: teleponController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Nomor telepon',
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                ),
                const SizedBox(height: 25),
                TombolUtama(
                  teks: 'MASUK',
                  onPressed: masuk,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// BERANDA
// ============================================================

class HomePage extends StatelessWidget {
  final String nama;
  final String telepon;

  const HomePage({
    super.key,
    required this.nama,
    required this.telepon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: warnaLatar,
        title: const Text(
          'BINTANG SERVICE',
          style: TextStyle(
            color: warnaEmas,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo, $nama',
                  style: const TextStyle(
                    color: warnaAbu,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Servis Motor\nAnda di Sini.',
                  style: TextStyle(
                    color: warnaPutih,
                    fontSize: 34,
                    height: 1.25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Pilih layanan perawatan motor dan tentukan jadwal servis Anda.',
                  style: TextStyle(
                    color: warnaAbu,
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 35),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: warnaKartu,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.build_circle_outlined,
                        color: warnaEmas,
                        size: 42,
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Booking Servis',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Pilih beberapa layanan dalam satu pemesanan.',
                              style: TextStyle(color: warnaAbu),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                TombolUtama(
                  teks: 'BUAT BOOKING',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ServiceSelectionPage(
                          nama: nama,
                          telepon: telepon,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    foregroundColor: warnaEmas,
                    side: const BorderSide(color: warnaEmas),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RiwayatBookingPage(
                          telepon: telepon,
                        ),
                      ),
                    );
                  },
                  child: const Text('RIWAYAT BOOKING'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// PEMILIHAN LAYANAN
// ============================================================

class ServiceSelectionPage extends StatefulWidget {
  final String nama;
  final String telepon;

  const ServiceSelectionPage({
    super.key,
    required this.nama,
    required this.telepon,
  });

  @override
  State<ServiceSelectionPage> createState() =>
      _ServiceSelectionPageState();
}

class _ServiceSelectionPageState extends State<ServiceSelectionPage> {
  final ApiService api = ApiService();

  List<ServiceItem> daftarLayanan = [];
  final Set<int> layananTerpilih = {};

  bool sedangMemuat = true;
  String? pesanError;

  @override
  void initState() {
    super.initState();
    ambilLayanan();
  }

  Future<void> ambilLayanan() async {
    setState(() {
      sedangMemuat = true;
      pesanError = null;
    });

    try {
      final hasil = await api.getServices();

      if (!mounted) return;

      setState(() {
        daftarLayanan = hasil;
        sedangMemuat = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        pesanError = e.toString().replaceFirst('Exception: ', '');
        sedangMemuat = false;
      });
    }
  }

  // ==========================================================
  // ATURAN PEMILIHAN LAYANAN
  // ==========================================================

  // Hanya satu produk Oli Mesin yang boleh dipilih.
  // Oli Gear dan layanan lainnya tetap bisa dipilih bersamaan.
  void pilihLayanan(ServiceItem item) {
    setState(() {
      // Jika layanan sudah dipilih, batalkan pilihan.
      if (layananTerpilih.contains(item.databaseId)) {
        layananTerpilih.remove(item.databaseId);
        return;
      }

      final kategori = item.kategori.trim().toLowerCase();

      // Jika memilih Oli Mesin baru, batalkan Oli Mesin sebelumnya.
      if (kategori == 'oli mesin') {
        for (final layanan in daftarLayanan) {
          if (layanan.kategori.trim().toLowerCase() == 'oli mesin') {
            layananTerpilih.remove(layanan.databaseId);
          }
        }
      }

      // Tambahkan layanan yang baru dipilih.
      layananTerpilih.add(item.databaseId);
    });
  }

  List<ServiceItem> get pilihanLayanan {
    return daftarLayanan
        .where((item) => layananTerpilih.contains(item.databaseId))
        .toList();
  }

  int get totalHarga {
    return pilihanLayanan.fold(
      0,
      (total, item) => total + item.harga,
    );
  }

  Map<String, List<ServiceItem>> get kelompokLayanan {
    final Map<String, List<ServiceItem>> hasil = {};

    for (final item in daftarLayanan) {
      hasil.putIfAbsent(item.kategori, () => []);
      hasil[item.kategori]!.add(item);
    }

    return hasil;
  }

  Widget kartuLayanan(ServiceItem item) {
    final dipilih = layananTerpilih.contains(item.databaseId);

    return InkWell(
      key: ValueKey('layanan_${item.databaseId}'),
      onTap: () => pilihLayanan(item),
      borderRadius: BorderRadius.circular(13),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: dipilih ? const Color(0xFF302719) : warnaKartu,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: dipilih ? warnaEmas : Colors.white12,
            width: dipilih ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              dipilih
                  ? Icons.check_circle
                  : Icons.circle_outlined,
              color: dipilih ? warnaEmas : warnaAbu,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.nama,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  if (item.deskripsi.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      item.deskripsi,
                      style: const TextStyle(
                        color: warnaAbu,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              formatRupiah(item.harga),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Layanan'),
        backgroundColor: warnaLatar,
      ),
      body: sedangMemuat
          ? const Center(
              child: CircularProgressIndicator(color: warnaEmas),
            )
          : pesanError != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.redAccent,
                          size: 45,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          pesanError!,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 18),
                        TombolUtama(
                          teks: 'COBA LAGI',
                          onPressed: ambilLayanan,
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: daftarLayanan.isEmpty
                          ? const Center(
                              child: Text('Katalog layanan masih kosong.'),
                            )
                          : ListView(
                              padding: const EdgeInsets.all(18),
                              children: [
                                const Text(
                                  'Pilih layanan yang dibutuhkan',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  'Anda dapat memilih beberapa layanan, tetapi hanya satu merek Oli Mesin dalam satu pemesanan.',
                                  style: TextStyle(
                                    color: warnaAbu,
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ...kelompokLayanan.entries.map((kelompok) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 12,
                                          bottom: 12,
                                        ),
                                        child: Text(
                                          kelompok.key,
                                          style: const TextStyle(
                                            color: warnaEmas,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      ...kelompok.value.map(kartuLayanan),
                                    ],
                                  );
                                }),
                              ],
                            ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: const BoxDecoration(
                        color: warnaKartu,
                        border: Border(
                          top: BorderSide(color: Colors.white12),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${layananTerpilih.length} layanan dipilih',
                                style: const TextStyle(color: warnaAbu),
                              ),
                              Text(
                                formatRupiah(totalHarga),
                                style: const TextStyle(
                                  color: warnaEmas,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 13),
                          TombolUtama(
                            teks: 'LANJUTKAN PEMESANAN',
                            onPressed: layananTerpilih.isEmpty
                                ? null
                                : () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => BookingPage(
                                          nama: widget.nama,
                                          telepon: widget.telepon,
                                          layanan: pilihanLayanan,
                                        ),
                                      ),
                                    );
                                  },
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
// FORM BOOKING
// ============================================================

class BookingPage extends StatefulWidget {
  final String nama;
  final String telepon;
  final List<ServiceItem> layanan;

  const BookingPage({
    super.key,
    required this.nama,
    required this.telepon,
    required this.layanan,
  });

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final ApiService api = ApiService();

  final motorController = TextEditingController();
  final nomorPolisiController = TextEditingController();

  DateTime? tanggalDipilih;
  TimeOfDay? jamDipilih;

  bool sedangMenyimpan = false;

  int get totalHarga {
    return widget.layanan.fold(
      0,
      (total, item) => total + item.harga,
    );
  }

  @override
  void dispose() {
    motorController.dispose();
    nomorPolisiController.dispose();
    super.dispose();
  }

  Future<void> pilihTanggal() async {
    final tanggal = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );

    if (tanggal != null) {
      setState(() {
        tanggalDipilih = tanggal;
      });
    }
  }

  Future<void> pilihJam() async {
    final jam = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );

    if (jam != null) {
      setState(() {
        jamDipilih = jam;
      });
    }
  }


Future<void> simpanBooking() async {
  if (motorController.text.trim().isEmpty ||
      nomorPolisiController.text.trim().isEmpty ||
      tanggalDipilih == null ||
      jamDipilih == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Lengkapi semua data pemesanan terlebih dahulu.',
        ),
      ),
    );
    return;
  }

  setState(() {
    sedangMenyimpan = true;
  });

  try {
    final tanggal =
        '${tanggalDipilih!.year.toString().padLeft(4, '0')}-'
        '${tanggalDipilih!.month.toString().padLeft(2, '0')}-'
        '${tanggalDipilih!.day.toString().padLeft(2, '0')}';

    final jam =
        '${jamDipilih!.hour.toString().padLeft(2, '0')}:'
        '${jamDipilih!.minute.toString().padLeft(2, '0')}';

    final hasil = await api.createBooking(
      name: widget.nama,
      phone: widget.telepon,
      bookingDate: tanggal,
      bookingTime: jam,
      motorcycleType: motorController.text.trim(),
      motorcycleNumber: nomorPolisiController.text.trim(),
      serviceIds: widget.layanan
          .map((item) => item.databaseId)
          .toSet()
          .toList(),
    );

    if (!mounted) return;

    final nomorBooking = (
      hasil['booking_id'] ??
      hasil['bookingId'] ??
      hasil['id_booking'] ??
      hasil['id'] ??
      '-'
    ).toString();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => SuccessPage(
          nama: widget.nama,
          telepon: widget.telepon,
          total: totalHarga,
          bookingId: nomorBooking,
          jenisMotor: motorController.text.trim(),
          nomorPolisi: nomorPolisiController.text.trim(),
          tanggal: tanggal,
          jam: jam,
          layanan: List<ServiceItem>.from(widget.layanan),
        ),
      ),
      (route) => route.isFirst,
    );
  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          e.toString().replaceFirst('Exception: ', ''),
        ),
      ),
    );
  } finally {
    if (mounted) {
      setState(() {
        sedangMenyimpan = false;
      });
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Pemesanan'),
        backgroundColor: warnaLatar,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Data Pelanggan',
            style: TextStyle(
              color: warnaEmas,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          _barisData('Nama', widget.nama),
          _barisData('Nomor telepon', widget.telepon),
          const SizedBox(height: 25),
          const Text(
            'Data Kendaraan',
            style: TextStyle(
              color: warnaEmas,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: motorController,
            decoration: const InputDecoration(
              labelText: 'Jenis / tipe motor',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: nomorPolisiController,
            textCapitalization: TextCapitalization.characters,
            decoration: const InputDecoration(
              labelText: 'Nomor polisi',
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            'Jadwal Servis',
            style: TextStyle(
              color: warnaEmas,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: pilihTanggal,
            icon: const Icon(Icons.calendar_month),
            label: Text(
              tanggalDipilih == null
                  ? 'Pilih tanggal servis'
                  : '${tanggalDipilih!.day}-'
                      '${tanggalDipilih!.month}-'
                      '${tanggalDipilih!.year}',
            ),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: pilihJam,
            icon: const Icon(Icons.access_time),
            label: Text(
              jamDipilih == null
                  ? 'Pilih jam servis'
                  : jamDipilih!.format(context),
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            'Ringkasan Layanan',
            style: TextStyle(
              color: warnaEmas,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          ...widget.layanan.map(
            (item) => _barisData(
              item.nama,
              formatRupiah(item.harga),
            ),
          ),
          const Divider(height: 30, color: Colors.white24),
          _barisData(
            'Total pembayaran',
            formatRupiah(totalHarga),
            tebal: true,
          ),
          const SizedBox(height: 25),
          TombolUtama(
            teks: sedangMenyimpan
                ? 'MENYIMPAN...'
                : 'KONFIRMASI BOOKING',
            onPressed: sedangMenyimpan ? null : simpanBooking,
          ),
        ],
      ),
    );
  }

  Widget _barisData(
    String kiri,
    String kanan, {
    bool tebal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              kiri,
              style: TextStyle(
                color: tebal ? warnaPutih : warnaAbu,
                fontWeight: tebal ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            kanan,
            style: TextStyle(
              color: tebal ? warnaEmas : warnaPutih,
              fontWeight: tebal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}


// ============================================================
// BOOKING BERHASIL
// ============================================================

class SuccessPage extends StatelessWidget {
  final String nama;
  final String telepon;
  final int total;
  final String bookingId;

  final String jenisMotor;
  final String nomorPolisi;
  final String tanggal;
  final String jam;
  final List<ServiceItem> layanan;

  const SuccessPage({
    super.key,
    required this.nama,
    required this.telepon,
    required this.total,
    required this.bookingId,
    required this.jenisMotor,
    required this.nomorPolisi,
    required this.tanggal,
    required this.jam,
    required this.layanan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: warnaLatar,
        title: const Text(
          'Detail Booking',
          style: TextStyle(color: warnaEmas),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: warnaHijau,
                  size: 80,
                ),
                const SizedBox(height: 15),

                const Text(
                  'Booking Berhasil!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'Terima kasih, $nama. Pemesanan servis Anda telah berhasil dikirim.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: warnaAbu,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 25),

                // NOMOR BOOKING
                _kartuBagian(
                  judul: 'Informasi Booking',
                  ikon: Icons.receipt_long,
                  isi: [
                    _barisDataStatic(
                      'Nomor booking',
                      bookingId,
                    ),
                    _barisDataStatic(
                      'Nama pelanggan',
                      nama,
                    ),
                    _barisDataStatic(
                      'Nomor telepon',
                      telepon,
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // DATA KENDARAAN
                _kartuBagian(
                  judul: 'Data Kendaraan',
                  ikon: Icons.two_wheeler,
                  isi: [
                    _barisDataStatic(
                      'Jenis / tipe motor',
                      jenisMotor,
                    ),
                    _barisDataStatic(
                      'Nomor polisi',
                      nomorPolisi,
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // JADWAL SERVIS
                _kartuBagian(
                  judul: 'Jadwal Servis',
                  ikon: Icons.calendar_month,
                  isi: [
                    _barisDataStatic(
                      'Tanggal servis',
                      tanggal,
                    ),
                    _barisDataStatic(
                      'Jam servis',
                      jam,
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // RINCIAN LAYANAN
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: warnaKartu,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.build_circle_outlined,
                            color: warnaEmas,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Rincian Layanan',
                            style: TextStyle(
                              color: warnaEmas,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      ...layanan.map(
                        (item) => _barisDataStatic(
                          item.nama,
                          formatRupiah(item.harga),
                        ),
                      ),

                      const Divider(
                        height: 30,
                        color: Colors.white24,
                      ),

                      _barisDataStatic(
                        'Total pembayaran',
                        formatRupiah(total),
                        tebal: true,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                TombolUtama(
                  teks: 'KEMBALI KE BERANDA',
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomePage(
                          nama: nama,
                          telepon: telepon,
                        ),
                      ),
                      (route) => false,
                    );
                  },
                ),

                const SizedBox(height: 15),

                const Text(
                  'Simpan informasi booking ini sebagai bukti pemesanan servis Anda.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: warnaAbu,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _kartuBagian({
    required String judul,
    required IconData ikon,
    required List<Widget> isi,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: warnaKartu,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(ikon, color: warnaEmas),
              const SizedBox(width: 10),
              Text(
                judul,
                style: const TextStyle(
                  color: warnaEmas,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ...isi,
        ],
      ),
    );
  }

  Widget _barisDataStatic(
    String kiri,
    String kanan, {
    bool tebal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              kiri,
              style: TextStyle(
                color: tebal ? warnaPutih : warnaAbu,
                fontWeight:
                    tebal ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 5,
            child: Text(
              kanan,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: tebal ? warnaEmas : warnaPutih,
                fontWeight:
                    tebal ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// RIWAYAT BOOKING
// ============================================================

class RiwayatBookingPage extends StatefulWidget {
  final String telepon;

  const RiwayatBookingPage({
    super.key,
    required this.telepon,
  });

  @override
  State<RiwayatBookingPage> createState() =>
      _RiwayatBookingPageState();
}

class _RiwayatBookingPageState extends State<RiwayatBookingPage> {
  final ApiService api = ApiService();

  late Future<List<Map<String, dynamic>>> futureRiwayat;

  @override
  void initState() {
    super.initState();
    futureRiwayat = api.getBookingHistory(phone: widget.telepon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Booking'),
        backgroundColor: warnaLatar,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: futureRiwayat,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: warnaEmas),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  snapshot.error.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final data = snapshot.data ?? [];

          if (data.isEmpty) {
            return const Center(
              child: Text('Belum ada riwayat booking.'),
            );
          }

          final Map<String, List<Map<String, dynamic>>> kelompok = {};

          for (final item in data) {
            final id = item['booking_id'].toString();
            kelompok.putIfAbsent(id, () => []);
            kelompok[id]!.add(item);
          }

          return ListView(
            padding: const EdgeInsets.all(18),
            children: kelompok.entries.map((entry) {
              final detail = entry.value;
              final pertama = detail.first;

              int total = 0;

              for (final item in detail) {
                final harga = ServiceItem.bacaHarga(item['price']);

                final jumlah =
                    int.tryParse(item['quantity']?.toString() ?? '1') ??
                        1;

                total += harga * jumlah;
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: warnaKartu,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booking #${entry.key}',
                      style: const TextStyle(
                        color: warnaEmas,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${pertama['motorcycle_type'] ?? '-'}'
                      ' • ${pertama['motorcycle_number'] ?? '-'}',
                      style: const TextStyle(color: warnaAbu),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${pertama['booking_date'] ?? '-'}'
                      ' • ${pertama['booking_time'] ?? '-'}',
                      style: const TextStyle(color: warnaAbu),
                    ),
                    const Divider(height: 25, color: Colors.white24),
                    ...detail.map(
                      (item) => _barisRiwayat(
                        item['service_name']?.toString() ?? '-',
                        formatRupiah(
                          ServiceItem.bacaHarga(item['price']),
                        ),
                      ),
                    ),
                    const Divider(height: 25, color: Colors.white24),
                    _barisRiwayat(
                      'Total',
                      formatRupiah(total),
                      tebal: true,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Status: ${pertama['status'] ?? 'Menunggu'}',
                      style: const TextStyle(color: warnaEmas),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _barisRiwayat(
    String kiri,
    String kanan, {
    bool tebal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              kiri,
              style: TextStyle(
                color: tebal ? warnaPutih : warnaAbu,
                fontWeight: tebal ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Text(
            kanan,
            style: TextStyle(
              color: tebal ? warnaEmas : warnaPutih,
              fontWeight: tebal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
