import 'json_utils.dart';

class BookingDetail {
  const BookingDetail({
    required this.serviceId,
    required this.serviceName,
    required this.price,
  });

  final int serviceId;
  final String serviceName;
  final int price;

  factory BookingDetail.fromJson(Map<String, dynamic> json) {
    return BookingDetail(
      serviceId: asInt(json['service_id']),
      serviceName: asString(json['service_name']),
      price: asInt(json['price']),
    );
  }
}

/// Data booking dari tabel `bookings` + `booking_details`.
class Booking {
  const Booking({
    required this.id,
    required this.bookingCode,
    required this.motorType,
    required this.plateNumber,
    required this.bookingDate,
    required this.bookingTime,
    required this.complaint,
    required this.status,
    required this.totalPrice,
    required this.details,
    required this.createdAt,
  });

  final int id;
  final String bookingCode;
  final String motorType;
  final String plateNumber;
  final String bookingDate;
  final String bookingTime;
  final String? complaint;
  final String status;
  final int totalPrice;
  final List<BookingDetail> details;
  final String createdAt;

  String get statusLabel {
    switch (status) {
      case 'pending':
        return 'Menunggu konfirmasi';
      case 'confirmed':
        return 'Dikonfirmasi';
      case 'in_progress':
        return 'Sedang dikerjakan';
      case 'completed':
        return 'Selesai';
      case 'cancelled':
        return 'Dibatalkan';
      default:
        return status;
    }
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    final rawDetails = json['details'];
    final complaint = json['complaint'];

    return Booking(
      id: asInt(json['id']),
      bookingCode: asString(json['booking_code']),
      motorType: asString(json['motor_type']),
      plateNumber: asString(json['plate_number']),
      bookingDate: asString(json['booking_date']),
      bookingTime: asString(json['booking_time']),
      complaint: complaint?.toString(),
      status: asString(json['status']),
      totalPrice: asInt(json['total_price']),
      details: rawDetails is List
          ? rawDetails
              .whereType<Map>()
              .map((item) => BookingDetail.fromJson(Map<String, dynamic>.from(item)))
              .toList()
          : const [],
      createdAt: asString(json['created_at']),
    );
  }
}
