import 'dart:async';

import 'package:firebase_1/screens/email_verification_screen.dart';
import 'package:firebase_1/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckVerificationPage extends StatefulWidget {
  const CheckVerificationPage({super.key});

  @override
  State<CheckVerificationPage> createState() => _CheckVerificationPageState();
}

class _CheckVerificationPageState extends State<CheckVerificationPage> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    timer = Timer.periodic(
        const Duration(seconds: 3), (timer) => checkEmailVerified());
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  Future checkEmailVerified() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.reload();
    }

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? const HomeScreen()
        : const EmailVerificationScreen();
  }
}
