import 'package:flutter/foundation.dart';

import '../core/network/api_exception.dart';
import '../core/state/view_status.dart';
import '../data/models/service_item.dart';
import '../data/repositories/layanan_repository.dart';

/// Detail satu layanan (GET /api/services/{id}).
class LayananDetailViewModel extends ChangeNotifier {
  LayananDetailViewModel(this._repository);

  final LayananRepository _repository;

  ViewStatus status = ViewStatus.initial;
  ServiceItem? service;
  String? errorMessage;
  int? _serviceId;

  Future<void> load(int id) async {
    _serviceId = id;
    status = ViewStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      service = await _repository.getServiceDetail(id);
      status = ViewStatus.success;
    } on ApiException catch (error) {
      errorMessage = error.message;
      status = ViewStatus.error;
    } catch (_) {
      errorMessage = 'Terjadi kesalahan tak terduga.';
      status = ViewStatus.error;
    }

    notifyListeners();
  }

  Future<void> retry() async {
    final id = _serviceId;
    if (id != null) await load(id);
  }
}
