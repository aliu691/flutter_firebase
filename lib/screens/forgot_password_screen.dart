import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helpers/app_toast.dart';
import '../helpers/validator.dart';
import '../notifier/auth_notifier.dart';
import '../notifier/auth_state.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/text_field_widget.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(loginNotifierProvider, (previous, state) {
      if (state is LoginStateError) {
        AppToasts().errorToast(state.error);
        setState(
          () {
            isLoading = false;
          },
        );
      }

      if (state is LoginStateSuccess) {
        setState(
          () {
            isLoading = false;
          },
        );
        AppToasts().successToast('please check your email for the link');

        Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
      }
    });
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
                    isLoading: isLoading,
                    text: 'Reset Password',
                    onTap: () {
                      final form = _formKey.currentState;
                      if (form?.validate() ?? false) {
                        ref.read(loginNotifierProvider.notifier).resetPassword(
                              emailController.text.trim(),
                            );
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
