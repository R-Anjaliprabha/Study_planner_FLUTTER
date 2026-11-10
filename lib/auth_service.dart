
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get currently logged-in user
  User? get currentUser => _auth.currentUser;

  // Register new user
  Future<UserCredential> signUp(
    String email,
    String password,
  ) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Login existing user
  Future<UserCredential> signIn(
    String email,
    String password,
  ) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Logout user
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
