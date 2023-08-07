import 'package:firebase_1/widgets/custom_button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Email not yet Verified'),
          const SizedBox(height: 50),
          CustomButtonWidget(
            text: 'Send Verification Email',
            onTap: () async {
              try {
                await FirebaseAuth.instance.currentUser!
                    .sendEmailVerification();
              } catch (e) {
                Fluttertoast.showToast(
                    msg: e.toString(),
                    textColor: Colors.white,
                    gravity: ToastGravity.TOP,
                    backgroundColor: Colors.red,
                    toastLength: Toast.LENGTH_LONG);
              }
            },
          ),
        ],
      ),
    );
  }
}
