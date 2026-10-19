import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queenbee/core/storage/secure_storage.dart';

/// URL de base de l'API, injectée au build :
/// `flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000/api/v1`
/// (10.0.2.2 = machine hôte vue depuis l'émulateur Android). Aucune valeur secrète ici.
const String kApiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://10.0.2.2:8000/api/v1',
);

/// Client HTTP (Dio) vers l'API FastAPI. Contrat : docs/openapi.yaml.
///
/// Règles (PLAYBOOK §7 MOBILE) :
///  - le réseau n'est JAMAIS sur le chemin de l'UI : on lit la base locale, on synchronise à part ;
///  - erreurs RFC 9457 (`application/problem+json`) ;
///  - toute écriture passe par l'outbox (core/sync/outbox.dart), jamais en appel direct depuis un écran ;
///  - en-tête `Idempotency-Key` sur les POST.
///
/// TODO(KAN-xxx, EP-07) : intercepteur de refresh (rotation du refresh token, un seul refresh
/// concurrent), certificate pinning (avec l'équipe Cyber), timeouts adaptés au réseau lent.
final dioProvider = Provider<Dio>((ref) {
  final tokens = ref.watch(tokenStoreProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: kApiBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Accept': 'application/json'},
    ),
  );
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final access = await tokens.readAccessToken();
        if (access != null) options.headers['Authorization'] = 'Bearer $access';
        handler.next(options);
      },
    ),
  );
  return dio;
});
