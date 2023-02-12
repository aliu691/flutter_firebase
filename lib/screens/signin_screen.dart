import 'package:firebase_1/resources/images.dart';
import 'package:firebase_1/widgets/alternate_login_widget.dart';
import 'package:firebase_1/widgets/custom_button_widget.dart';
import 'package:firebase_1/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
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
                CustomButtonWidget(text: 'SignIn', onTap: () {}),
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
                    const Text(
                      'Register Now',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.blue),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}