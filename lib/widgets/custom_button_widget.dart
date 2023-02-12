import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget(
      {required this.text, required this.onTap, super.key});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ));
  }
}
