import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queenbee/data/local/app_database.dart';
import 'package:queenbee/data/remote/hive_remote_source.dart';
import 'package:queenbee/features/alerts/domain/alert.dart';

/// Repository des alertes (UC-A02). Lecture locale ; mise à jour par `refresh` / push FCM.
abstract interface class AlertRepository {
  Stream<List<HiveAlert>> watchAlerts();
  Future<void> refresh();
}

class AlertRepositoryImpl implements AlertRepository {
  AlertRepositoryImpl(this._db, this._remote);

  // ignore: unused_field
  final AppDatabase _db;
  // ignore: unused_field
  final HiveRemoteSource _remote;

  @override
  Stream<List<HiveAlert>> watchAlerts() {
    throw UnimplementedError('TODO(KAN-xxx, EP-07): watchAlerts');
  }

  @override
  Future<void> refresh() async {
    throw UnimplementedError('TODO(KAN-xxx, EP-07): refresh alerts');
  }
}

final alertRepositoryProvider = Provider<AlertRepository>(
  (ref) => AlertRepositoryImpl(
    ref.watch(appDatabaseProvider),
    ref.watch(hiveRemoteSourceProvider),
  ),
);
