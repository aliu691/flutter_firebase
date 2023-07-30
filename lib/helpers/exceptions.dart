import 'auth_exceptions.dart';

class AppExceptionsHandler {
  handleFirebaseExceptions(String code) {
    if (code == 'user-not-found') {
      throw AuthException('User not found');
    } else if (code == 'wrong-password') {
      throw AuthException('Wrong Password');
    } else if (code == 'weak-password') {
      throw AuthException('The password provided is too weak.');
    } else if (code == 'email-already-in-use') {
      throw AuthException('The account already exists for that email.');
    } else {
      throw AuthException('An error occured, please try again later');
    }
  }
}
