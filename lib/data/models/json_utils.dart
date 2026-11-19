/// Pembacaan JSON yang aman: angka bisa datang sebagai int, double, atau teks.
int asInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ??
      double.tryParse(value?.toString() ?? '')?.toInt() ??
      0;
}

String asString(dynamic value) => value?.toString() ?? '';

bool asBool(dynamic value) {
  return value == true || value == 1 || value == '1' || value == 'true';
}
