# android

Ce dossier est volontairement **vide de code natif** : le squelette a été écrit à la main sans lancer Flutter.

Pour générer les projets Android/iOS (une seule fois, depuis `apps/mobile`) :

```bash
cd apps/mobile
flutter create . --project-name queenbee --org org.beeafrica --platforms android,ios
```

Cette commande ajoute `android/`, `ios/` et complète le projet **sans écraser** `lib/`, `pubspec.yaml` ni `analysis_options.yaml` existants (vérifier avec `git diff` avant de committer).

Réglages Android à faire ensuite (ticket MOBILE) :
- `minSdkVersion` >= 23 (exigé par `flutter_secure_storage` et SQLCipher) ;
- permissions : `CAMERA` (QR + photo), `ACCESS_NETWORK_STATE`, `POST_NOTIFICATIONS` (Android 13+). **Pas** `INTERNET` superflu ni stockage large ;
- Firebase : ajouter `google-services.json` **hors du dépôt** (fichier à ne pas committer, voir `.gitignore`) ;
- signature de release : keystore **jamais committé**, secrets via CI ;
- taille : viser un APK < 30 Mo (`flutter build apk --split-per-abi`), voir `docs/eco-conception/checklist.md`.
