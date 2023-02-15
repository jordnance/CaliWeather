import 'package:caliweather/userverify.dart';
import 'package:flutter/material.dart';
import 'package:caliweather/sql_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:caliweather/components/textfield_login.dart';
import 'package:caliweather/components/header_login_profile.dart';
import 'package:caliweather/globals.dart' as globals;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? usernameValue;
  String? passwordValue;
  String? newUsernameValue;
  String? newPasswordValue;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //final TextEditingController _newUsernameController = TextEditingController();
  //final TextEditingController _newPasswordController = TextEditingController();

  // temporary function until final ui for displaying error messages
  void showMessage(String message) {
    if (mounted) {
      setState(() {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating, content: Text(message)));
      });
    }
  }

  void clearTextControllers() {
    _usernameController.text = '';
    _passwordController.text = '';
  }

  void _signIn() async {
    setState(() {
      usernameValue = _usernameController.text;
      passwordValue = _passwordController.text;
    });

    var user = await SQLHelper.getUserByUsername(usernameValue ?? "");

    if (user.isEmpty) {
      showMessage("User not found");
      clearTextControllers();
      return;
    }

    if (user[0]['password'] != passwordValue) {
      showMessage("Incorrect Password");
      clearTextControllers();
      return;
    }

    // get shrd_pref instance
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    // set shrd_pref flag for login
    _prefs.setBool("isLoggedIn", true);
    // set user data in shrd_pref
    _prefs.setInt("userId", user[0]['userId']);
    _prefs.setString("userFirstName", user[0]['firstName']);
    globals.user_id = _prefs.getInt('userId') ?? 0;
    globals.userFirstName = user[0]['firstName'];

    // show welcome message
    showMessage("Welcome back ${usernameValue}!");
    clearTextControllers();
    FocusScope.of(context).unfocus();
    Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserVerify()))
        .then((value) {
      initState();
    });
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
                TextfieldLogin(
                  controller: _usernameController,
                  hintText: "Username",
                  sufIcon: const Icon(Icons.email),
                  obscureTextFlag: false,
                ),
                const SizedBox(height: 5),
                TextfieldLogin(
                  controller: _passwordController,
                  hintText: "Password",
                  sufIcon: const Icon(Icons.password),
                  obscureTextFlag: true,
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: _signIn,
                    style: ElevatedButton.styleFrom(
                        elevation: 3,
                        minimumSize: const Size.fromHeight(60),
                        backgroundColor: const Color.fromARGB(255, 0, 83, 129),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        )),
                    child: const Text('Sign In'),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                // Start: Bottom divider
                // aligned to match with Profile page bottom divider
                const SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[600],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          'No account?',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(width: 3),
                      const Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child: Text(
                          'Register here',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
