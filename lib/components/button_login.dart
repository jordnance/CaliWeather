import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final Color bgColor;
  final VoidCallback onCustomButtonPressed;

  const AuthButton({
    super.key,
    required this.buttonText,
    required this.bgColor,
    required this.onCustomButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            elevation: 3,
            minimumSize: const Size.fromHeight(60),
            backgroundColor: bgColor,
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            )),
        child: Text(buttonText),
      ),
    );
  }
}
