import 'json_utils.dart';

/// Satu layanan bengkel dari tabel `services` (GET /api/services).
class ServiceItem {
  const ServiceItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.durationMinutes,
    required this.isActive,
  });

  final int id;
  final String name;
  final String description;
  final int price;
  final int durationMinutes;
  final bool isActive;

  factory ServiceItem.fromJson(Map<String, dynamic> json) {
    return ServiceItem(
      id: asInt(json['id']),
      name: asString(json['name']),
      description: asString(json['description']),
      price: asInt(json['price']),
      durationMinutes: asInt(json['duration_minutes']),
      isActive: json['is_active'] == null ? true : asBool(json['is_active']),
    );
  }
}
