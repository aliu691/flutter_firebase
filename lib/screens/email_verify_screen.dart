import 'package:firebase_1/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helpers/app_toast.dart';
import '../notifier/auth_notifier.dart';
import '../notifier/auth_state.dart';

class VerifyEmailScreen extends ConsumerWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(loginNotifierProvider, (previous, state) {
      if (state is LoginStateError) {
        AppToasts().errorToast(state.error);
      }

      if (state is LoginStateSuccess) {
        AppToasts().successToast('please check your email for the link');

        ref.read(loginNotifierProvider.notifier).signOut();

        //Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
      }
    });
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: (() => ref.read(loginNotifierProvider.notifier).signOut()),
            child: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Email is not Verified'),
            const SizedBox(height: 50),
            CustomButtonWidget(
                text: 'Verify Email',
                onTap: () {
                  ref.read(loginNotifierProvider.notifier).sendActivateEmail();
                  // AppToasts()
                  //     .successToast('please check your email for the link');

                  // ref.read(loginNotifierProvider.notifier).signOut();
                })
          ],
        ),
      ),
    );
  }
}
