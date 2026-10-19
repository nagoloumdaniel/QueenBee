import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:queenbee/core/auth/auth_controller.dart';
import 'package:queenbee/core/theme/tokens.dart';
import 'package:queenbee/features/auth/domain/credentials.dart';
import 'package:queenbee/l10n/gen/app_localizations.dart';

/// Écran de connexion (UC-T01).
///
/// États à gérer (PLAYBOOK §6) : chargement (bouton désactivé + indicateur), erreur générique
/// (« Identifiants incorrects »), hors-ligne (message clair : la première connexion exige le réseau),
/// MFA (écran de saisie du code TOTP : TODO ticket EP-07).
/// Accessibilité : champs avec libellé, `autofillHints`, bouton >= 48 dp, erreur annoncée (liveRegion).
///
/// TODO(KAN-xxx, EP-07) : appeler `AuthController.login`, afficher le chargement, gérer le MFA.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final credentials = Credentials(email: _email.text.trim(), password: _password.text);
    if (!credentials.isComplete) return;
    await ref
        .read(authControllerProvider.notifier)
        .login(email: credentials.email, password: credentials.password);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final auth = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.loginTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(QbSpacing.s6),
          children: [
            TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.username],
              decoration: InputDecoration(labelText: l10n.loginEmail),
            ),
            const SizedBox(height: QbSpacing.s4),
            TextField(
              controller: _password,
              obscureText: true,
              autofillHints: const [AutofillHints.password],
              decoration: InputDecoration(labelText: l10n.loginPassword),
              onSubmitted: (_) => _submit(),
            ),
            if (auth.error != null) ...[
              const SizedBox(height: QbSpacing.s4),
              Semantics(
                liveRegion: true,
                child: Text(
                  l10n.loginError,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            ],
            const SizedBox(height: QbSpacing.s6),
            FilledButton(onPressed: _submit, child: Text(l10n.loginSubmit)),
          ],
        ),
      ),
    );
  }
}
