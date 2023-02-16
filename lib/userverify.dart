import 'login.dart';
import 'profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:caliweather/globals.dart' as globals;

class UserVerify extends StatefulWidget {
  const UserVerify({super.key});

  @override
  State<UserVerify> createState() => _UserVerifyState();
}

class _UserVerifyState extends State<UserVerify> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<bool> isLoggedIn;

  @override
  void initState() {
    isLoggedIn = _prefs.then((SharedPreferences prefs) {
      return (prefs.getBool('isLoggedIn') ?? false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isLoggedIn,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              if (snapshot.data == true) {
                () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  globals.user_id = prefs.getInt("userId")!;
                };
                return const ProfilePage();
              }
              return const LoginPage();
            }
        }
      },
    );
  }
}
