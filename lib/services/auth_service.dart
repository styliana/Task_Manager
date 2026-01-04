import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Getter obecnego użytkownika
  User? get currentUser => _auth.currentUser;

  // Słuchacz zmian stanu
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  // 1. LOGOWANIE ANONIMOWE (Gość)
  Future<User?> signInAnonymously() async {
    try {
      final result = await _auth.signInAnonymously();
      return result.user;
    } catch (e) {
      // Rzucamy błąd wyżej, żeby UI mógł go wyświetlić
      throw e;
    }
  }

  // 2. LOGOWANIE MAILEM
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      return result.user;
    } catch (e) {
      throw e;
    }
  }

  // 3. REJESTRACJA MAILEM
  Future<User?> registerWithEmail(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      return result.user;
    } catch (e) {
      throw e;
    }
  }

  // Wylogowanie
  Future<void> signOut() async {
    await _auth.signOut();
  }
}