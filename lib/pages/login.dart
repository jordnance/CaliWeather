import '../util/userverify.dart';
import 'package:flutter/material.dart';
import '../util/sql_helper.dart';
import '../util/sharedprefutil.dart';
import 'components/textfield_login.dart';
import 'components/header_login_profile.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? usernameValue;
  String? passwordValue;
  String? newFirstNameValue;
  String? newLastNameValue;
  String? newUsernameValue;
  String? newPasswordValue;
  String? forgotUsernameValue;
  String? forgotPasswordValue;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newFirstNameController = TextEditingController();
  final TextEditingController _newLastNameController = TextEditingController();
  final TextEditingController _newUsernameController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _forgotUsernameController =
      TextEditingController();
  final TextEditingController _forgotPasswordController =
      TextEditingController();

  // temporary function until final ui for displaying error messages
  void showMessage(String message) {
    if (mounted) {
      setState(() {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
              behavior: SnackBarBehavior.fixed,
              padding: const EdgeInsets.only(
                  left: 24, top: 14, right: 0, bottom: 24),
              content: Text(message)));
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

    //NO ERRORS FOUND, FINISH LOGIN
    var userinfo = await SQLHelper.getUserInfo(user[0]['userId']);
    SharedPrefUtil.setUserLogin(userinfo[0]);
    showMessage("Welcome back ${SharedPrefUtil.getUserFirstName()}!");
    clearTextControllers();
    if (context.mounted) {
      FocusScope.of(context).unfocus();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const UserVerify()));
    }
  }

  void _forgotPassword() async {
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        useRootNavigator: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom + 260,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _forgotUsernameController,
                    decoration: const InputDecoration(hintText: 'Username'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _forgotPasswordController,
                    decoration: const InputDecoration(hintText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        forgotUsernameValue = _forgotUsernameController.text;
                        forgotPasswordValue = _forgotPasswordController.text;
                      });
                      await _updatePassword();
                      Navigator.of(context, rootNavigator: true).pop(context);
                    },
                    child: const Text('Confirm'),
                  )
                ],
              ),
            ));
  }

  Future<void> _updatePassword() async {
    if (forgotUsernameValue == '' || forgotPasswordValue == '') {
      showMessage('Fields cannot be empty');
    } else {
      SQLHelper.updatePassword(forgotUsernameValue, forgotPasswordValue);
      showMessage("You've successfully updated your password!");
    }

    _forgotUsernameController.text = '';
    _forgotPasswordController.text = '';
    setState(() {});
  }

  void _resigterForm() async {
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        useRootNavigator: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom + 260,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _newFirstNameController,
                    decoration: const InputDecoration(hintText: 'First Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _newLastNameController,
                    decoration: const InputDecoration(hintText: 'Last Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _newUsernameController,
                    decoration: const InputDecoration(hintText: 'Username'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _newPasswordController,
                    decoration: const InputDecoration(hintText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        newFirstNameValue = _newFirstNameController.text;
                        newLastNameValue = _newLastNameController.text;
                        newUsernameValue = _newUsernameController.text;
                        newPasswordValue = _newPasswordController.text;
                      });
                      await _addUser();
                      Navigator.of(context, rootNavigator: true).pop(context);
                      showMessage("You've successfully signed up!");
                    },
                    child: const Text('Sign Up'),
                  )
                ],
              ),
            ));
  }

  Future<void> _addUser() async {
    SQLHelper.createUser(newFirstNameValue, newLastNameValue, newUsernameValue,
        newPasswordValue);
    _newFirstNameController.text = '';
    _newLastNameController.text = '';
    _newUsernameController.text = '';
    _newPasswordController.text = '';
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
                        onTap: _forgotPassword,
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
                          onTap: _resigterForm,
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
