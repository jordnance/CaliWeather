import 'package:flutter/material.dart';

class TextfieldLogin extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon sufIcon;
  final bool obscureTextFlag;

  const TextfieldLogin({
    super.key,
    required this.controller,
    required this.hintText,
    required this.sufIcon,
    required this.obscureTextFlag,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureTextFlag,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade500)),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          suffixIcon: sufIcon,
          label: Text.rich(
            TextSpan(
              children: <InlineSpan>[
                WidgetSpan(
                  child: Text(
                    '$hintText',
                  ),
                ),
              ],
            ),
          ),
        ),
        onTapOutside: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }
}
