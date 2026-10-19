import 'package:flutter/material.dart';
import 'package:queenbee/core/theme/tokens.dart';

/// `ThemeData` clair et sombre construits UNIQUEMENT à partir des tokens.
///
/// TODO(KAN-xxx, MOBILE) : embarquer Inter (UI) et Fraunces (titres) puis renseigner
/// `fontFamily` ; vérifier les contrastes (>= 4,5:1) avec l'outil de contraste.
abstract final class AppTheme {
  static ThemeData light() {
    const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: QbColors.honey,
      onPrimary: QbColors.earth,
      secondary: QbColors.leaf,
      onSecondary: Colors.white,
      error: QbColors.alert,
      onError: Colors.white,
      surface: QbColors.surface,
      onSurface: QbColors.earth,
    );
    return _base(scheme, QbColors.cream);
  }

  static ThemeData dark() {
    const scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: QbColors.honey,
      onPrimary: QbColors.earth,
      secondary: Color(0xFF8FC27A),
      onSecondary: QbColors.darkBackground,
      error: QbColors.darkAlert,
      onError: QbColors.darkBackground,
      surface: QbColors.darkSurface,
      onSurface: QbColors.cream,
    );
    return _base(scheme, QbColors.darkBackground);
  }

  static ThemeData _base(ColorScheme scheme, Color background) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      visualDensity: VisualDensity.standard,
      // Cibles tactiles >= 48 dp
      materialTapTargetSize: MaterialTapTargetSize.padded,
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(kQbMinTarget, kQbMinTarget),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(QbRadius.sm),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(kQbMinTarget, kQbMinTarget),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(QbRadius.sm),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(QbRadius.sm),
        ),
        contentPadding: const EdgeInsets.all(QbSpacing.s4),
      ),
      // TODO(KAN-xxx, MOBILE) : cardTheme (rayon QbRadius.lg) - classe CardTheme/CardThemeData
      // selon la version de Flutter retenue au premier `flutter pub get`.
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: QbFontSize.display),
        headlineMedium: TextStyle(fontSize: QbFontSize.title),
        titleMedium: TextStyle(fontSize: QbFontSize.subtitle),
        bodyLarge: TextStyle(fontSize: QbFontSize.body),
        bodyMedium: TextStyle(fontSize: QbFontSize.small),
        bodySmall: TextStyle(fontSize: QbFontSize.caption),
      ),
    );
  }
}
