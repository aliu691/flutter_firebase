import 'package:firebase_1/helpers/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  AuthRepository(this._auth);

  final FirebaseAuth _auth;

  Stream<User?> get authStateChanges => _auth.idTokenChanges();

  bool get isEmailVerified => _auth.currentUser!.emailVerified;

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

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      AppExceptionsHandler().handleFirebaseExceptions(e.code);
    }
  }

  Future<void> sendActivateEmail() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      AppExceptionsHandler().handleFirebaseExceptions(e.code);
    }
  }

  Future<void> reloadUser() async {
    try {
      await _auth.currentUser!.reload();
    } on FirebaseAuthException catch (e) {
      AppExceptionsHandler().handleFirebaseExceptions(e.code);
    }
  }
}
