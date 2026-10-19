import 'package:drift/drift.dart';

/// Tables Drift (SQLite chiffré SQLCipher). Sous-ensemble mobile du modèle serveur
/// (ROADMAP §4.9) : seulement ce dont l'apiculteur a besoin hors ligne.
///
/// Conventions :
///  - `id` = UUID texte (celui du serveur) ; `clientUuid` = UUID généré sur l'appareil pour les
///    entités créées hors ligne (idempotence de la sync) ;
///  - dates en UTC ; `version` = numéro de version serveur (résolution de conflit) ;
///  - `syncStatus` : 'synced' | 'pending' | 'conflict'.
/// Après toute modification : `dart run build_runner build` puis migration (schemaVersion).

@DataClassName('HiveRow')
class Hives extends Table {
  TextColumn get id => text()();
  TextColumn get code => text()(); // ex. SN-CASA-014
  TextColumn get siteId => text()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  TextColumn get status => text().withDefault(const Constant('active'))();
  RealColumn get lastWeightKg => real().nullable()();
  IntColumn get healthScore => integer().nullable()(); // 0..100
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('InspectionRow')
class Inspections extends Table {
  TextColumn get clientUuid => text()();
  TextColumn get serverId => text().nullable()();
  TextColumn get hiveId => text()();
  DateTimeColumn get inspectedAt => dateTime()();
  TextColumn get visualState => text().nullable()();
  BoolColumn get queenPresent => boolean().nullable()();
  TextColumn get behavior => text().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get anomaly => boolean().withDefault(const Constant(false))();
  IntColumn get version => integer().withDefault(const Constant(1))();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {clientUuid};
}

@DataClassName('InspectionPhotoRow')
class InspectionPhotos extends Table {
  TextColumn get clientUuid => text()();
  TextColumn get inspectionClientUuid => text()();
  TextColumn get localPath => text()(); // fichier redimensionné/WebP dans le stockage de l'app
  TextColumn get sha256 => text().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column<Object>> get primaryKey => {clientUuid};
}

@DataClassName('HarvestRow')
class Harvests extends Table {
  TextColumn get clientUuid => text()();
  TextColumn get serverId => text().nullable()();
  TextColumn get hiveId => text()();
  DateTimeColumn get harvestedOn => dateTime()();
  RealColumn get volumeKg => real()();
  TextColumn get status => text().withDefault(const Constant('declared'))();
  IntColumn get version => integer().withDefault(const Constant(1))();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column<Object>> get primaryKey => {clientUuid};
}

@DataClassName('AlertRow')
class Alerts extends Table {
  TextColumn get id => text()();
  TextColumn get hiveId => text().nullable()();
  TextColumn get type => text()(); // enum SQL alert_type
  TextColumn get severity => text()(); // info | warning | critical
  TextColumn get status => text()(); // open | acknowledged | ...
  TextColumn get recommendation => text().nullable()();
  DateTimeColumn get detectedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// File d'envoi (voir core/sync/outbox.dart).
@DataClassName('OutboxRow')
class OutboxEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entityType => text()(); // inspection | inspectionPhoto | harvest
  TextColumn get clientUuid => text()();
  TextColumn get operation => text()(); // create | update
  TextColumn get payloadJson => text()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

/// Curseur du dernier pull (GET /sync/pull?since=...).
@DataClassName('SyncCursorRow')
class SyncCursors extends Table {
  TextColumn get name => text()(); // 'default'
  TextColumn get cursor => text().nullable()();
  DateTimeColumn get lastPulledAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {name};
}
