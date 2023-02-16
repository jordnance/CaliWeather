import 'package:caliweather/userverify.dart';
import 'package:flutter/material.dart';
import 'package:caliweather/sql_helper.dart';
import 'package:caliweather/sharedprefutil.dart';
import 'package:caliweather/components/textfield_login.dart';
import 'package:caliweather/components/header_login_profile.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

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
    //SAVE USER INPUT TO SAFE VAR
    setState(() {
      usernameValue = _usernameController.text;
      passwordValue = _passwordController.text;
    });

    //QUERY DB FOR USER INFORMATION
    var user = await SQLHelper.getUserByUsername(usernameValue ?? "");

    //CATCH ERRORS AND RETURN
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

    //NOT ERRORS FOUND, FINISH LOGIN
    var userinfo = await SQLHelper.getUserInfo(user[0]['userId']);
    SharedPrefUtil.setUserLogin(userinfo[0]);
    showMessage("Welcome back ${SharedPrefUtil.getUserFirstName()}!");
    clearTextControllers();
    FocusScope.of(context).unfocus();
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: const UserVerify(),
      withNavBar: true, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  void _testing() async {
    // var userinfo = await SQLHelper.getUserInfo(1);
    // print(userinfo);
    //SharedPrefUtil.setUserLogin(userinfo[0]);
    SharedPrefUtil.checkAllPrefs();
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
                      InkWell(
                        onTap: _testing,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
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
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: InkWell(
                          onTap: _testing,
                          child: const Text(
                            'Register here',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
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
