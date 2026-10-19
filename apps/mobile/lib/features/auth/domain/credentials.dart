/// Identifiants saisis à l'écran de connexion (jamais journalisés, jamais persistés).
class Credentials {
  const Credentials({required this.email, required this.password});

  final String email;
  final String password;

  /// Validation minimale côté client (le serveur reste la référence).
  bool get isComplete => email.contains('@') && password.isNotEmpty;
}
