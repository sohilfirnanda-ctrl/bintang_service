import 'package:flutter/foundation.dart';

import '../core/network/api_exception.dart';
import '../core/state/view_status.dart';
import '../data/models/service_item.dart';
import '../data/repositories/layanan_repository.dart';

/// Daftar layanan di Beranda: loading, success, empty, error,
/// pull-to-refresh, filter pencarian, dan pilihan layanan untuk booking.
class LayananListViewModel extends ChangeNotifier {
  LayananListViewModel(this._repository);

  final LayananRepository _repository;

  ViewStatus status = ViewStatus.initial;
  List<ServiceItem> services = [];
  String? errorMessage;
  String query = '';
  bool isRefreshing = false;

  final Map<int, ServiceItem> _selected = {};
  int _requestId = 0;

  List<ServiceItem> get selectedServices => _selected.values.toList();
  int get selectedCount => _selected.length;
  int get selectedTotal =>
      _selected.values.fold(0, (total, service) => total + service.price);

  bool isSelected(int id) => _selected.containsKey(id);

  Future<void> load({bool refresh = false}) async {
    final requestId = ++_requestId;

    if (refresh) {
      isRefreshing = true;
    } else {
      status = ViewStatus.loading;
    }
    errorMessage = null;
    notifyListeners();

    try {
      final result = await _repository.getServices(search: query);
      if (requestId != _requestId) return; // respons lama, abaikan

      services = result;
      status = result.isEmpty ? ViewStatus.empty : ViewStatus.success;
    } on ApiException catch (error) {
      if (requestId != _requestId) return;
      errorMessage = error.message;
      status = ViewStatus.error;
    } catch (_) {
      if (requestId != _requestId) return;
      errorMessage = 'Terjadi kesalahan tak terduga.';
      status = ViewStatus.error;
    } finally {
      if (requestId == _requestId) {
        isRefreshing = false;
        notifyListeners();
      }
    }
  }

  Future<void> refresh() => load(refresh: true);

  Future<void> retry() => load();

  Future<void> search(String value) {
    query = value.trim();
    return load();
  }

  void toggle(ServiceItem service) {
    if (_selected.containsKey(service.id)) {
      _selected.remove(service.id);
    } else {
      _selected[service.id] = service;
    }
    notifyListeners();
  }

  void select(ServiceItem service) {
    _selected[service.id] = service;
    notifyListeners();
  }

  void clearSelection() {
    _selected.clear();
    notifyListeners();
  }

  /// Dipanggil saat logout agar data akun sebelumnya tidak terbawa.
  void reset() {
    _requestId++;
    status = ViewStatus.initial;
    services = [];
    errorMessage = null;
    query = '';
    isRefreshing = false;
    _selected.clear();
    notifyListeners();
  }
}
