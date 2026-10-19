import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queenbee/core/router.dart';
import 'package:queenbee/core/theme/app_theme.dart';
import 'package:queenbee/l10n/gen/app_localizations.dart';

/// Racine de l'application : thème QueenBee (clair/sombre), français, routeur.
class QueenBeeApp extends ConsumerWidget {
  const QueenBeeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // i18n prêt pour les langues locales : ajouter un fichier app_<code>.arb
      supportedLocales: const [Locale('fr')],
      locale: const Locale('fr'),
    );
  }
}
