import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:queenbee/data/local/tables.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';
import 'package:sqlite3/open.dart';

// Fichier généré par : dart run build_runner build --delete-conflicting-outputs
part 'app_database.g.dart';

/// Base locale chiffrée : SOURCE de l'UI (offline-first).
@DriftDatabase(
  tables: [
    Hives,
    Inspections,
    InspectionPhotos,
    Harvests,
    Alerts,
    OutboxEntries,
    SyncCursors,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  /// Ouvre (ou crée) le fichier chiffré avec la clé lue dans le stockage sécurisé.
  ///
  /// TODO(KAN-xxx, EP-07) : valider le contournement SQLCipher selon la doc Drift en vigueur
  /// (`isolateSetup`, `open.overrideFor`), tester sur Android 6 et un appareil bas de gamme,
  /// et vérifier que le fichier n'est PAS lisible avec `sqlite3` sans clé.
  factory AppDatabase.open({required String encryptionKeyHex}) {
    return AppDatabase(
      LazyDatabase(() async {
        final dir = await getApplicationSupportDirectory();
        final file = File(p.join(dir.path, 'queenbee.sqlite'));
        return NativeDatabase.createInBackground(
          file,
          isolateSetup: () async {
            await applyWorkaroundToOpenSqlCipherOnOldAndroidVersions();
            open.overrideFor(OperatingSystem.android, openCipherOnAndroid);
          },
          setup: (rawDb) {
            // Clé binaire passée en hexadécimal : ne jamais journaliser cette valeur.
            rawDb.execute("PRAGMA key = \"x'$encryptionKeyHex'\";");
          },
        );
      }),
    );
  }

  /// Base en mémoire pour les tests (non chiffrée).
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        // TODO(KAN-xxx, EP-07) : onUpgrade avec étapes de migration testées
        // (drift_dev schema steps) - ne JAMAIS supprimer des données utilisateur non synchronisées.
      );
}

/// Fourni au démarrage (main.dart) après lecture de la clé : `ProviderScope(overrides: [...])`.
final appDatabaseProvider = Provider<AppDatabase>(
  (ref) => throw UnimplementedError(
    'TODO(KAN-xxx, EP-07): override appDatabaseProvider dans main.dart',
  ),
);
