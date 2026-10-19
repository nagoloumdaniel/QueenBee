import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Vrai quand une interface réseau est disponible.
///
/// ATTENTION : « interface disponible » != « internet joignable ». Le vrai test est le succès
/// d'un appel (voir SyncService). Ce flux ne sert qu'à déclencher une tentative de sync et
/// à afficher la bannière.
final isOnlineProvider = StreamProvider<bool>((ref) async* {
  final connectivity = Connectivity();
  yield _hasNetwork(await connectivity.checkConnectivity());
  yield* connectivity.onConnectivityChanged.map(_hasNetwork);
});

bool _hasNetwork(List<ConnectivityResult> results) =>
    results.any((r) => r != ConnectivityResult.none);
