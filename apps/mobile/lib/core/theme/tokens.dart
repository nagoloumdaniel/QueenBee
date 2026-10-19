import 'package:flutter/material.dart';

/// Tokens de design QueenBee (ROADMAP §4.7) - SOURCE UNIQUE côté mobile.
///
/// Mêmes valeurs que le web : apps/web/src/app/globals.css.
/// Si une valeur change ici, la changer là-bas dans la MÊME PR.
/// Règle : jamais de `Color(0x...)` dans une feature, toujours un token ou le `ThemeData`.
abstract final class QbColors {
  static const Color honey = Color(0xFFE8A317);
  static const Color amber = Color(0xFF8A5A00);
  static const Color earth = Color(0xFF3B2A1A);
  static const Color leaf = Color(0xFF4C7A3A);
  static const Color cream = Color(0xFFFBF5E6);
  static const Color alert = Color(0xFFC0392B);

  // Rôles sémantiques
  static const Color surface = Color(0xFFFFFFFF);
  static const Color muted = Color(0xFF6B5844);
  static const Color border = Color(0xFFE3D6B8);

  // Mode sombre
  static const Color darkBackground = Color(0xFF1F1610);
  static const Color darkSurface = Color(0xFF2B2017);
  static const Color darkMuted = Color(0xFFCDBD9F);
  static const Color darkAlert = Color(0xFFF28B7D);
}

/// Espacement sur une grille de 4 px.
abstract final class QbSpacing {
  static const double s1 = 4;
  static const double s2 = 8;
  static const double s3 = 12;
  static const double s4 = 16;
  static const double s6 = 24;
  static const double s8 = 32;
}

/// Rayons de bordure : 8 (petits éléments) et 16 (cartes).
abstract final class QbRadius {
  static const double sm = 8;
  static const double lg = 16;
}

/// Durées de motion : 150 ms (micro-interactions) et 250 ms (transitions).
/// Respecter `MediaQuery.disableAnimations` (reduced motion).
abstract final class QbMotion {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration base = Duration(milliseconds: 250);
}

/// Échelle typographique : 12 / 14 / 16 / 20 / 28 / 40.
abstract final class QbFontSize {
  static const double caption = 12;
  static const double small = 14;
  static const double body = 16;
  static const double subtitle = 20;
  static const double title = 28;
  static const double display = 40;
}

/// Cible tactile minimale (objectif projet : 48 dp, WCAG 2.5.8).
const double kQbMinTarget = 48;
