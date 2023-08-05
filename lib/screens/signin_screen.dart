import 'package:firebase_1/helpers/validator.dart';
import 'package:firebase_1/notifier/auth_notifier.dart';
import 'package:firebase_1/notifier/auth_state.dart';
import 'package:firebase_1/resources/images.dart';
import 'package:firebase_1/widgets/alternate_login_widget.dart';
import 'package:firebase_1/widgets/custom_button_widget.dart';
import 'package:firebase_1/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helpers/app_toast.dart';
import 'forgot_password_screen.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      loginNotifierProvider,
      ((prevoius, state) {
        if (state is LoginStateError) {
          AppToasts().errorToast(state.error);
          setState(() {
            isLoading = false;
          });
        }

        if (state is LoginStateLoading) {
          setState(() {
            isLoading = true;
          });
        }
      }),
    );

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
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordScreen(),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomButtonWidget(
                          text: 'SignIn',
                          isLoading: isLoading,
                          onTap: () {
                            final form = _formKey.currentState;
                            if (form?.validate() ?? false) {
                              ref.read(loginNotifierProvider.notifier).login(
                                  emailController.text.trim(),
                                  passwordController.text);
                            }
                          },
                        ),
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
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                              'Not a memeber?  ',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: const Text(
                                'Register Now',
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
