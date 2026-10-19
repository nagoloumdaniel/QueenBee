import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queenbee/core/network/api_client.dart';

/// Endpoints de synchronisation : POST /sync/push et GET /sync/pull?since=.
///
/// Contrat (à figer dans docs/openapi.yaml par le ticket API EP-06) :
///  - push : corps = lot d'éléments `{entity, client_uuid, version, data}` ;
///    réponse = un résultat par élément : `ok | conflict | error` (+ version/état serveur pour `conflict`) ;
///  - pull : `since` = curseur opaque ; réponse = changements + nouveau curseur.
/// Tous les POST envoient `Idempotency-Key` (identifiant du lot).
class SyncRemoteSource {
  SyncRemoteSource(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> push(
    List<Map<String, dynamic>> batch, {
    required String idempotencyKey,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/sync/push',
      data: {'items': batch},
      options: Options(headers: {'Idempotency-Key': idempotencyKey}),
    );
    return res.data ?? <String, dynamic>{};
  }

  Future<Map<String, dynamic>> pull({String? since}) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/sync/pull',
      queryParameters: {if (since != null) 'since': since},
    );
    return res.data ?? <String, dynamic>{};
  }
}

final syncRemoteSourceProvider = Provider<SyncRemoteSource>(
  (ref) => SyncRemoteSource(ref.watch(dioProvider)),
);
