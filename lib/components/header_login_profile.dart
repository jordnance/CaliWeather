import 'package:flutter/material.dart';

class HeaderLoginProfile extends StatelessWidget {
  const HeaderLoginProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 50),
        Image.asset(
          'lib/images/Logo1a_nobg_bold_rounded.png',
          height: 225,
        ),
        const SizedBox(height: 15),
        Text(
          'Your Home for California Meteorology',
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 25),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Divider(
            thickness: 0.5,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
