import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queenbee/core/storage/secure_storage.dart';

/// Statut d'authentification de l'apiculteur (rôle `beekeeper`, UC-T01).
enum AuthStatus { unknown, unauthenticated, authenticated }

class AuthState {
  const AuthState({required this.status, this.userId, this.error});

  final AuthStatus status;
  final String? userId;

  /// Message AFFICHABLE (générique) : ne jamais révéler si l'e-mail existe.
  final String? error;
}

/// Contrôleur d'authentification.
///
/// Exigences (ROADMAP §5.7, PLAYBOOK §7 AUTH) :
///  - login e-mail + mot de passe -> POST /auth/login ; MFA (TOTP) si le rôle l'exige ;
///  - jeton d'accès 15 min + refresh rotatif 30 j stockés dans `TokenStore` (Keystore/Keychain) ;
///  - restauration de session AU DÉMARRAGE sans réseau (offline long) ;
///  - déconnexion : POST /auth/logout quand le réseau est là, jetons effacés dans tous les cas.
///
/// TODO(KAN-xxx, EP-07/EP-03) : implémenter `restore`, `login`, `logout`
/// (dépôt d'authentification dans data/remote/auth_remote_source.dart).
class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthState(status: AuthStatus.unauthenticated);

  TokenStore get _tokens => ref.read(tokenStoreProvider);

  /// Restaure la session depuis le stockage sécurisé (sans appel réseau).
  Future<void> restore() async {
    final refresh = await _tokens.readRefreshToken();
    state = refresh == null
        ? const AuthState(status: AuthStatus.unauthenticated)
        : const AuthState(status: AuthStatus.authenticated);
    // TODO(KAN-xxx, EP-07) : extraire userId du jeton, vérifier l'expiration locale.
  }

  Future<void> login({required String email, required String password}) async {
    // TODO(KAN-xxx, EP-07/EP-03) : appel API, gestion MFA, verrouillage (5 essais).
    state = const AuthState(
      status: AuthStatus.unauthenticated,
      error: 'TODO: login non implémenté',
    );
  }

  Future<void> logout() async {
    await _tokens.clearTokens();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}

final authControllerProvider =
    NotifierProvider<AuthController, AuthState>(AuthController.new);
