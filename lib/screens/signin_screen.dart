import 'package:firebase_1/resources/images.dart';
import 'package:firebase_1/widgets/alternate_login_widget.dart';
import 'package:firebase_1/widgets/custom_button_widget.dart';
import 'package:firebase_1/widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                    height: 50,
                  ),
                  const Icon(
                    Icons.lock,
                    size: 100,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Welcome Back, You have been Missed'),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                    controller: emailController,
                    hintText: 'Enter Email',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFieldWidget(
                    controller: passwordController,
                    hintText: 'Enter Password',
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  CustomButtonWidget(
                      text: 'SignIn',
                      onTap: () async {
                        try {
                          showDialog(
                            context: context,
                            builder: ((context) => const Center(
                                  child: CircularProgressIndicator(),
                                )),
                          );
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: emailController.text.trim(),
                            password: passwordController.text,
                          );
                          if (mounted) {
                            Navigator.pop(context);
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            if (kDebugMode) {
                              print('No user found for that email.');
                            }
                          } else if (e.code == 'wrong-password') {
                            if (kDebugMode) {
                              print('Wrong password provided for that user.');
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
                      AlternateLoginWidget(imageUrl: AppImages.googleIcon),
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
                        'Not a memeber?  ',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Register Now',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.blue),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
