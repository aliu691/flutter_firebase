import 'package:firebase_1/providers/auth_provider.dart';
import 'package:firebase_1/screens/home_screen.dart';
import 'package:firebase_1/screens/login_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);
    return authState.when(
      data: (user) {
        if (user != null) {
          return const HomeScreen();
        }
        return const LoginOrRegisterScreen();
      },
      error: (error, stackTrace) => const Center(
        child: Text('Error loading page'),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
