import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:queenbee/core/auth/auth_controller.dart';
import 'package:queenbee/core/widgets/home_shell.dart';
import 'package:queenbee/features/alerts/presentation/alerts_screen.dart';
import 'package:queenbee/features/auth/presentation/login_screen.dart';
import 'package:queenbee/features/harvest/presentation/harvest_screen.dart';
import 'package:queenbee/features/hive_detail/presentation/hive_detail_screen.dart';
import 'package:queenbee/features/hives/presentation/hives_screen.dart';
import 'package:queenbee/features/inspection/presentation/inspection_screen.dart';
import 'package:queenbee/features/profile_sync/presentation/profile_sync_screen.dart';

/// Noms de routes : une seule source de vérité pour la navigation.
abstract final class Routes {
  static const login = '/login';
  static const hives = '/hives';
  static const alerts = '/alerts';
  static const harvest = '/harvest';
  static const profile = '/profile';
  static String hiveDetail(String id) => '/hives/$id';
  static String newInspection(String hiveId) => '/hives/$hiveId/inspection';
}

/// Routeur : redirige vers /login tant que l'utilisateur n'est pas authentifié.
///
/// Rappel offline-first : un utilisateur DÉJÀ connecté reste authentifié hors ligne
/// (refresh de 30 jours stocké chiffré, ROADMAP §1). Ne jamais exiger le réseau pour ouvrir l'app.
final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref
    ..listen<AuthState>(authControllerProvider, (_, __) => refresh.value++)
    ..onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: Routes.hives,
    refreshListenable: refresh,
    redirect: (context, state) {
      final authenticated =
          ref.read(authControllerProvider).status == AuthStatus.authenticated;
      final onLogin = state.matchedLocation == Routes.login;
      if (!authenticated) return onLogin ? null : Routes.login;
      if (onLogin) return Routes.hives;
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => HomeShell(child: child),
        routes: [
          GoRoute(
            path: Routes.hives,
            builder: (context, state) => const HivesScreen(),
            routes: [
              GoRoute(
                path: ':id',
                builder: (context, state) =>
                    HiveDetailScreen(hiveId: state.pathParameters['id']!),
                routes: [
                  GoRoute(
                    path: 'inspection',
                    builder: (context, state) =>
                        InspectionScreen(hiveId: state.pathParameters['id']!),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: Routes.alerts,
            builder: (context, state) => const AlertsScreen(),
          ),
          GoRoute(
            path: Routes.harvest,
            builder: (context, state) => const HarvestScreen(),
          ),
          GoRoute(
            path: Routes.profile,
            builder: (context, state) => const ProfileSyncScreen(),
          ),
        ],
      ),
    ],
  );
});
