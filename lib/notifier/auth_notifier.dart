import 'package:firebase_1/notifier/auth_state.dart';
import 'package:firebase_1/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginNotifierProvider = StateNotifierProvider<LoginNotifier, LoginState>(
    (ref) => LoginNotifier(ref));

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier(this.ref) : super(const LoginStateInitial());

  final Ref ref;

  void login(String email, String password) async {
    state = const LoginStateLoading();
    try {
      await ref
          .read(authRepositoryProvider)
          .signInwithEmailAndPassword(email, password);
      state = const LoginStateSuccess();
    } catch (e) {
      state = LoginStateError(e.toString());
    }
  }

  void signOut() async {
    await ref.read(authRepositoryProvider).signOut();
  }

  void signUp(String email, String password) async {
    state = const LoginStateLoading();
    try {
      await ref
          .read(authRepositoryProvider)
          .signUpWithEmailAndPassword(email, password);
      state = const LoginStateSuccess();
    } catch (e) {
      state = LoginStateError(e.toString());
    }
  }

  void resetPassword(String email) async {
    state = const LoginStateLoading();
    try {
      await ref.read(authRepositoryProvider).resetPassword(email);
      state = const LoginStateSuccess();
    } catch (e) {
      state = LoginStateError(e.toString());
    }
  }
}
