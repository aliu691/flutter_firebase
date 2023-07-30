import 'package:firebase_1/helpers/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  AuthRepository(this._auth);

  final FirebaseAuth _auth;

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  Future<User?> signInwithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      AppExceptionsHandler().handleFirebaseExceptions(e.code);
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      AppExceptionsHandler().handleFirebaseExceptions(e.code);
    }
    return null;
  }
}
