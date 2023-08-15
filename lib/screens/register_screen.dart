import 'package:cloud_firestore/cloud_firestore.dart';
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
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
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
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Text('Welcome, Lets Get you Started'),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFieldWidget(
                          controller: nameController,
                          hintText: 'Enter Name',
                          validator: InputValidator.text,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldWidget(
                          controller: ageController,
                          hintText: 'Enter Age',
                          validator: InputValidator.text,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldWidget(
                          controller: emailController,
                          hintText: 'Enter Email',
                          validator: InputValidator.email,
                        ),
                        const SizedBox(
                          height: 20,
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
                        const SizedBox(height: 20),
                        CustomButtonWidget(
                          text: 'SignUp',
                          onTap: _signup,
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
                              width: 20,
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

  _signup() async {
    final form = _formKey.currentState;
    if (form?.validate() ?? false) {
      try {
        showDialog(
          context: context,
          builder: ((context) => const Center(
                child: CircularProgressIndicator(),
              )),
        );
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );

        _createUser(
            name: nameController.text.trim(),
            age: int.parse(ageController.text.trim()),
            email: emailController.text.trim());

        if (mounted) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          if (kDebugMode) {
            print('The password provided is too weak.');
          }
        } else if (e.code == 'email-already-in-use') {
          if (kDebugMode) {
            print('The account already exists for that email.');
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }
}

_createUser({
  required String name,
  required int age,
  required String email,
}) async {
  await FirebaseFirestore.instance.collection('users').add({
    'name': name,
    'age': age,
    'email': email,
  });
  if (kDebugMode) {
    print('created user');
  }
}
