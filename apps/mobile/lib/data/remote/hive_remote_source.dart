import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queenbee/core/network/api_client.dart';

/// Appels API relatifs aux ruches, alertes, inspections et récoltes (contrat : docs/openapi.yaml).
///
/// Ces sources distantes ne sont appelées QUE par les repositories et par `SyncService`,
/// jamais par un écran. Les réponses sont de simples `Map` JSON ici ; le mapping vers
/// les objets de domaine se fait dans les repositories.
///
/// TODO(KAN-xxx, EP-07) : typer les DTO (à partir d'OpenAPI), pagination par curseur, ETag.
class HiveRemoteSource {
  HiveRemoteSource(this._dio);

  final Dio _dio;

  /// GET /hives
  Future<List<Map<String, dynamic>>> fetchHives({String? cursor}) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/hives',
      queryParameters: {if (cursor != null) 'cursor': cursor},
    );
    final items = (res.data?['items'] as List<dynamic>? ?? <dynamic>[]);
    return items.cast<Map<String, dynamic>>();
  }

  /// GET /hives/by-qr/{token}
  Future<Map<String, dynamic>> fetchHiveByQr(String token) async {
    final res = await _dio.get<Map<String, dynamic>>('/hives/by-qr/$token');
    return res.data ?? <String, dynamic>{};
  }

  /// GET /alerts
  Future<List<Map<String, dynamic>>> fetchAlerts() async {
    final res = await _dio.get<Map<String, dynamic>>('/alerts');
    final items = (res.data?['items'] as List<dynamic>? ?? <dynamic>[]);
    return items.cast<Map<String, dynamic>>();
  }
}

final hiveRemoteSourceProvider = Provider<HiveRemoteSource>(
  (ref) => HiveRemoteSource(ref.watch(dioProvider)),
);
