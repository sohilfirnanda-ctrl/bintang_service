import '../models/service_item.dart';
import '../services/layanan_service.dart';

class LayananRepository {
  LayananRepository(this._service);

  final LayananService _service;

  /// Hanya layanan aktif yang ditampilkan ke pelanggan.
  Future<List<ServiceItem>> getServices({String search = ''}) async {
    final rows = await _service.fetchServices(search: search.trim());
    return rows
        .map(ServiceItem.fromJson)
        .where((service) => service.isActive)
        .toList();
  }

  Future<ServiceItem> getServiceDetail(int id) async {
    final row = await _service.fetchServiceDetail(id);
    return ServiceItem.fromJson(row);
  }
}
