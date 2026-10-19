import 'package:flutter_test/flutter_test.dart';
import 'package:queenbee/core/theme/tokens.dart';

/// Garde-fou : les tokens mobile doivent rester identiques à ceux du web
/// (apps/web/src/app/globals.css). Si ce test échoue après un changement volontaire,
/// mettre à jour LES DEUX fichiers dans la même PR.
void main() {
  test('les couleurs de marque correspondent au ROADMAP §4.7', () {
    expect(QbColors.honey.toARGB32(), 0xFFE8A317);
    expect(QbColors.amber.toARGB32(), 0xFF8A5A00);
    expect(QbColors.earth.toARGB32(), 0xFF3B2A1A);
    expect(QbColors.leaf.toARGB32(), 0xFF4C7A3A);
    expect(QbColors.cream.toARGB32(), 0xFFFBF5E6);
    expect(QbColors.alert.toARGB32(), 0xFFC0392B);
  });

  test('la cible tactile minimale est de 48 dp', () {
    expect(kQbMinTarget, 48);
  });
}
