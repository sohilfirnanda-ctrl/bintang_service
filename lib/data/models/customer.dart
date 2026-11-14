import 'json_utils.dart';

class Customer {
  const Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
  });

  final int id;
  final String name;
  final String email;
  final String phone;
  final String role;

  bool get isAdmin => role == 'admin';

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: asInt(json['id']),
      name: asString(json['name']),
      email: asString(json['email']),
      phone: asString(json['phone']),
      role: asString(json['role']),
    );
  }
}
