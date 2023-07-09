import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../helpers/validator.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/text_field_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Type your email to receive password reset link'),
            const SizedBox(
              height: 50,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFieldWidget(
                      controller: emailController,
                      hintText: 'Enter Email',
                      validator: InputValidator.email,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    CustomButtonWidget(
                      text: 'Reset Password',
                      onTap: _resetPassword,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  _resetPassword() async {
    final form = _formKey.currentState;
    if (form?.validate() ?? false) {
      try {
        showDialog(
          context: context,
          builder: ((context) => const Center(
                child: CircularProgressIndicator(),
              )),
        );
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim(),
        );
        if (mounted) {
          Navigator.pop(context);
        }
        Fluttertoast.showToast(
            msg: 'please check your email for the link',
            textColor: Colors.white,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.red,
            toastLength: Toast.LENGTH_LONG);
        if (mounted) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Fluttertoast.showToast(
              msg: 'No user found for that email.',
              textColor: Colors.white,
              gravity: ToastGravity.TOP,
              backgroundColor: Colors.red,
              toastLength: Toast.LENGTH_LONG);
          Navigator.pop(context);
        }
      }
    }
  }
}
