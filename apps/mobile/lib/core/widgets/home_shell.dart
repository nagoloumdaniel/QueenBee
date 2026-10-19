import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:queenbee/core/router.dart';
import 'package:queenbee/core/widgets/offline_banner.dart';
import 'package:queenbee/l10n/gen/app_localizations.dart';

/// Cadre commun des 4 onglets : bannière hors-ligne + barre de navigation.
/// Chaque destination a une icône ET un texte (jamais l'icône seule).
class HomeShell extends StatelessWidget {
  const HomeShell({required this.child, super.key});

  final Widget child;

  static const _tabs = [
    Routes.hives,
    Routes.alerts,
    Routes.harvest,
    Routes.profile,
  ];

  int _indexFor(String location) {
    final i = _tabs.indexWhere(location.startsWith);
    return i < 0 ? 0 : i;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final location = GoRouterState.of(context).matchedLocation;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OfflineBanner(),
            Expanded(child: child),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indexFor(location),
        onDestinationSelected: (i) => context.go(_tabs[i]),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.hive_outlined),
            label: l10n.navHives,
          ),
          NavigationDestination(
            icon: const Icon(Icons.notifications_outlined),
            label: l10n.navAlerts,
          ),
          NavigationDestination(
            icon: const Icon(Icons.scale_outlined),
            label: l10n.navHarvest,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            label: l10n.navProfile,
          ),
        ],
      ),
    );
  }
}
