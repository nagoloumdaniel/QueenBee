import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queenbee/app.dart';

/// Point d'entrée de l'application terrain QueenBee.
///
/// TODO(KAN-xxx, MOBILE) :
///  - initialiser Firebase (`Firebase.initializeApp`) pour les notifications push (FCM) ;
///  - ouvrir la base Drift chiffrée (clé lue dans le stockage sécurisé) et la fournir
///    via `appDatabaseProvider` (voir lib/data/local/app_database.dart).
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: QueenBeeApp()));
}
