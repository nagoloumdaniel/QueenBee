import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Stockage des secrets de l'appareil : Android Keystore / iOS Keychain
/// (via `flutter_secure_storage`). ROADMAP §5.7 « Données ».
///
/// Contient : jeton d'accès, refresh token (30 j, offline long) et la CLÉ de la base SQLCipher.
/// INTERDIT : stocker ces valeurs dans SharedPreferences, fichiers, logs ou code source.
///
/// TODO(KAN-xxx, EP-07) : options Android (`encryptedSharedPreferences`), invalidation à la
/// déconnexion, génération de la clé SQLCipher au premier lancement (32 octets aléatoires).
class TokenStore {
  TokenStore([FlutterSecureStorage? storage])
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const _kAccess = 'access_token';
  static const _kRefresh = 'refresh_token';
  static const _kDbKey = 'db_encryption_key';

  Future<String?> readAccessToken() => _storage.read(key: _kAccess);
  Future<String?> readRefreshToken() => _storage.read(key: _kRefresh);

  Future<void> saveTokens({required String access, required String refresh}) async {
    await _storage.write(key: _kAccess, value: access);
    await _storage.write(key: _kRefresh, value: refresh);
  }

  /// Efface les jetons (déconnexion). La clé de base est conservée pour ne pas rendre
  /// la base locale illisible (données non synchronisées !). Décision à valider : ADR-0003.
  Future<void> clearTokens() async {
    await _storage.delete(key: _kAccess);
    await _storage.delete(key: _kRefresh);
  }

  Future<String?> readDatabaseKey() => _storage.read(key: _kDbKey);
  Future<void> saveDatabaseKey(String key) =>
      _storage.write(key: _kDbKey, value: key);
}

final tokenStoreProvider = Provider<TokenStore>((ref) => TokenStore());
