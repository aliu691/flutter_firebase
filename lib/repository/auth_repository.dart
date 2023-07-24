import 'package:firebase_1/helpers/auth_exceptions.dart';
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
      if (e.code == 'user-not-found') {
        throw AuthException('User not found');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Wrong Password');
      } else {
        throw AuthException('An error occured, please try again later');
      }
    }
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
      if (e.code == 'weak-password') {
        throw AuthException('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('The account already exists for that email.');
      } else {
        throw AuthException('An error occured, please try again later');
      }
    }
  }
}
