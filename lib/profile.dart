import 'package:flutter/material.dart';
import 'package:caliweather/components/button_login.dart';
import 'package:caliweather/components/header_login_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userFirstName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Start: Header Section; shared with profile page
                const HeaderLoginProfile(),

                // Start: Login Section
                Text(
                  'Welcome, $userFirstName!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 25),
                AuthButton(
                  buttonText: 'Preferences',
                  bgColor: Color.fromARGB(255, 37, 37, 37),
                  onCustomButtonPressed: () {},
                ),
                const SizedBox(height: 15),
                AuthButton(
                  buttonText: 'Profile Info',
                  bgColor: Color.fromARGB(255, 37, 37, 37),
                  onCustomButtonPressed: () {},
                ),
                const SizedBox(height: 15),
                AuthButton(
                  buttonText: 'Sign Out',
                  bgColor: const Color.fromARGB(255, 0, 83, 129),
                  onCustomButtonPressed: () {},
                ),

                // Start: Bottom divider
                // aligned to match with Login page bottom divider
                const SizedBox(height: 36),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[600],
                  ),
                ),
                // End: Bottom divider
              ],
            ),
          ),
        ),
      ),
    );
  }
}
