import '../../core/network/api_client.dart';

class LayananService {
  LayananService(this._client);

  final ApiClient _client;

  /// GET /api/services?search=oli&per_page=50
  Future<List<Map<String, dynamic>>> fetchServices({String? search}) async {
    final body = await _client.get(
      '/services',
      query: {
        'per_page': 50,
        if (search != null && search.isNotEmpty) 'search': search,
      },
    );
    return ApiClient.unwrapList(body);
  }

  /// GET /api/services/{id}
  Future<Map<String, dynamic>> fetchServiceDetail(int id) async {
    final body = await _client.get('/services/$id');
    return ApiClient.unwrapMap(body);
  }
}
