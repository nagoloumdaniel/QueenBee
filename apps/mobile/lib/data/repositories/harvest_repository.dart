import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queenbee/core/sync/outbox.dart';
import 'package:queenbee/data/local/app_database.dart';
import 'package:queenbee/features/harvest/domain/harvest.dart';

/// Repository des récoltes (UC-A03). Même principe que les inspections : Drift + outbox.
abstract interface class HarvestRepository {
  Stream<List<Harvest>> watchHarvests();
  Future<void> declare(Harvest harvest);
}

class HarvestRepositoryImpl implements HarvestRepository {
  HarvestRepositoryImpl(this._db, this._outbox);

  // ignore: unused_field
  final AppDatabase _db;
  // ignore: unused_field
  final OutboxRepository _outbox;

  @override
  Stream<List<Harvest>> watchHarvests() {
    throw UnimplementedError('TODO(KAN-xxx, EP-07): watchHarvests');
  }

  @override
  Future<void> declare(Harvest harvest) async {
    throw UnimplementedError('TODO(KAN-xxx, EP-07): declare harvest');
  }
}

final harvestRepositoryProvider = Provider<HarvestRepository>(
  (ref) => HarvestRepositoryImpl(
    ref.watch(appDatabaseProvider),
    ref.watch(outboxRepositoryProvider),
  ),
);
