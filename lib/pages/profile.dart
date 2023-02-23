import 'settings.dart';
import 'package:flutter/material.dart';
import 'components/header_login_profile.dart';
import '../util/sharedprefutil.dart';
import '../util/userverify.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'components/profile_info.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _signOut() async {
    SharedPrefUtil.setLogout();
    if (context.mounted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const UserVerify()));
    }
  }

  void _profileInfo() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ProfileInfo()),
    );
  }

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
                  'Welcome, ${SharedPrefUtil.getUserFirstName()}!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const SettingsPage(title: 'Settings'),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 3,
                        minimumSize: const Size.fromHeight(60),
                        backgroundColor: const Color.fromARGB(255, 37, 37, 37),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        )),
                    child: const Text('Preferences'),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: _profileInfo,
                    style: ElevatedButton.styleFrom(
                        elevation: 3,
                        minimumSize: const Size.fromHeight(60),
                        backgroundColor: const Color.fromARGB(255, 0, 83, 129),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        )),
                    child: const Text('Profile Info'),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: _signOut,
                    style: ElevatedButton.styleFrom(
                        elevation: 3,
                        minimumSize: const Size.fromHeight(60),
                        backgroundColor: const Color.fromARGB(255, 0, 83, 129),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        )),
                    child: const Text('Sign Out'),
                  ),
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
