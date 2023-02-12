import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AlternateLoginWidget extends StatelessWidget {
  const AlternateLoginWidget({required this.imageUrl, super.key});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: SvgPicture.asset(
          imageUrl,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
