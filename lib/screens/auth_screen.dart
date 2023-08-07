import 'package:firebase_1/screens/check_verification_page.dart';
import 'package:firebase_1/screens/login_register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const CheckVerificationPage();
          } else {
            return const LoginOrRegisterScreen();
          }
        },
      ),
    );
  }
}
