import 'package:firebase_1/helpers/validator.dart';
import 'package:firebase_1/resources/images.dart';
import 'package:firebase_1/widgets/alternate_login_widget.dart';
import 'package:firebase_1/widgets/custom_button_widget.dart';
import 'package:firebase_1/widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Icon(
                    Icons.lock,
                    size: 100,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Welcome, Lets Get you Started'),
                  const SizedBox(
                    height: 20,
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
                          height: 30,
                        ),
                        TextFieldWidget(
                          controller: passwordController,
                          hintText: 'Enter Password',
                          obscureText: true,
                          validator: InputValidator.password,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFieldWidget(
                          controller: confirmPasswordController,
                          hintText: 'Confirm Password',
                          obscureText: true,
                          validator: (value) => InputValidator.confirmPassword(
                              value, passwordController.text),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(height: 30),
                        CustomButtonWidget(
                            text: 'SignUp',
                            onTap: () async {
                              final form = _formKey.currentState;
                              if (form?.validate() ?? false) {
                                try {
                                  showDialog(
                                    context: context,
                                    builder: ((context) => const Center(
                                          child: CircularProgressIndicator(),
                                        )),
                                  );
                                  if (passwordController.text ==
                                      confirmPasswordController.text) {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                      email: emailController.text.trim(),
                                      password: passwordController.text,
                                    );
                                  } else {
                                    if (kDebugMode) {
                                      print('Passwords don\'t match');
                                    }
                                  }

                                  if (mounted) {
                                    Navigator.pop(context);
                                  }
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    if (kDebugMode) {
                                      print(
                                          'The password provided is too weak.');
                                    }
                                  } else if (e.code == 'email-already-in-use') {
                                    if (kDebugMode) {
                                      print(
                                          'The account already exists for that email.');
                                    }
                                  }
                                } catch (e) {
                                  if (kDebugMode) {
                                    print(e);
                                  }
                                }
                              }
                            }),
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              ),
                            ),
                            const Text('Or Continue with'),
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            AlternateLoginWidget(
                                imageUrl: AppImages.googleIcon),
                            SizedBox(
                              width: 30,
                            ),
                            AlternateLoginWidget(imageUrl: AppImages.appleIcon)
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?  ',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.blue),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
