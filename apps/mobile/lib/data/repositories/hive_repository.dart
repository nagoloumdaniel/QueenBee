import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queenbee/data/local/app_database.dart';
import 'package:queenbee/data/remote/hive_remote_source.dart';
import 'package:queenbee/features/hives/domain/hive.dart';

/// Repository des ruches (pattern repository : l'UI ne voit que ce contrat).
///
/// Offline-first : `watchHives` lit TOUJOURS Drift. `refresh` interroge l'API et met Drift à jour ;
/// son échec (hors ligne) n'est pas une erreur d'affichage.
abstract interface class HiveRepository {
  Stream<List<Hive>> watchHives();
  Stream<Hive?> watchHive(String id);
  Future<void> refresh();
}

class HiveRepositoryImpl implements HiveRepository {
  HiveRepositoryImpl(this._db, this._remote);

  final AppDatabase _db;
  final HiveRemoteSource _remote;

  @override
  Stream<List<Hive>> watchHives() {
    // TODO(KAN-xxx, EP-07) : (_db.select(_db.hives)..orderBy(...)).watch().map(toDomain)
    throw UnimplementedError('TODO(KAN-xxx, EP-07): watchHives');
  }

  @override
  Stream<Hive?> watchHive(String id) {
    throw UnimplementedError('TODO(KAN-xxx, EP-07): watchHive');
  }

  @override
  Future<void> refresh() async {
    // TODO(KAN-xxx, EP-07) : _remote.fetchHives() -> upsert dans _db.hives (batch, transaction)
    throw UnimplementedError('TODO(KAN-xxx, EP-07): refresh hives');
  }
}

final hiveRepositoryProvider = Provider<HiveRepository>(
  (ref) => HiveRepositoryImpl(
    ref.watch(appDatabaseProvider),
    ref.watch(hiveRemoteSourceProvider),
  ),
);
