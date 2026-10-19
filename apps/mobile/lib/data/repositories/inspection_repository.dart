import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queenbee/core/sync/outbox.dart';
import 'package:queenbee/data/local/app_database.dart';
import 'package:queenbee/features/inspection/domain/inspection.dart';

/// Repository des inspections (UC-A01).
///
/// `saveInspection` ne fait JAMAIS d'appel réseau : il écrit dans Drift et dans l'outbox,
/// dans une seule transaction, puis rend la main immédiatement (affichage instantané).
abstract interface class InspectionRepository {
  Stream<List<Inspection>> watchForHive(String hiveId);
  Future<void> saveInspection(Inspection inspection);
}

class InspectionRepositoryImpl implements InspectionRepository {
  InspectionRepositoryImpl(this._db, this._outbox);

  // ignore: unused_field
  final AppDatabase _db;
  // ignore: unused_field
  final OutboxRepository _outbox;

  @override
  Stream<List<Inspection>> watchForHive(String hiveId) {
    throw UnimplementedError('TODO(KAN-xxx, EP-07): watchForHive');
  }

  @override
  Future<void> saveInspection(Inspection inspection) async {
    // TODO(KAN-xxx, EP-07) :
    //   await _db.transaction(() async {
    //     insert dans _db.inspections (syncStatus = 'pending')
    //     await _outbox.enqueue(type: inspection, clientUuid: ..., operation: create, payload: ...)
    //   });
    throw UnimplementedError('TODO(KAN-xxx, EP-07): saveInspection');
  }
}

final inspectionRepositoryProvider = Provider<InspectionRepository>(
  (ref) => InspectionRepositoryImpl(
    ref.watch(appDatabaseProvider),
    ref.watch(outboxRepositoryProvider),
  ),
);
