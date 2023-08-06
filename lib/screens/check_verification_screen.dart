import 'package:firebase_1/notifier/auth_notifier.dart';
import 'package:firebase_1/providers/auth_provider.dart';
import 'package:firebase_1/screens/email_verify_screen.dart';
import 'package:firebase_1/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckEmailVerificationPage extends ConsumerStatefulWidget {
  const CheckEmailVerificationPage({super.key});
  @override
  ConsumerState<CheckEmailVerificationPage> createState() =>
      _CheckEmailVerificationPageState();
}

class _CheckEmailVerificationPageState
    extends ConsumerState<CheckEmailVerificationPage> {
  @override
  Widget build(BuildContext context) {
    ref.read(loginNotifierProvider.notifier).reloadUser();

    final isEmailVerified = ref.watch(isEmailVerifiedProvider);

    return isEmailVerified ? const HomeScreen() : const VerifyEmailScreen();
  }
}
