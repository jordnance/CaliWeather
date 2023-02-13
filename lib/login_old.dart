import 'sql_helper.dart';
import 'globals.dart' as globals;
import 'package:flutter/material.dart';

class LoginPageOld extends StatefulWidget {
  const LoginPageOld({super.key, required this.title});
  final String title;

  @override
  State<LoginPageOld> createState() => _LoginPageOldState();
}

class _LoginPageOldState extends State<LoginPageOld> {
  String? usernameValue;
  String? passwordValue;
  String? newUsernameValue;
  String? newPasswordValue;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newUsernameController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

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

  void _showForm() async {
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom + 200,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        newUsernameValue = _newUsernameController.text;
                        newPasswordValue = _newPasswordController.text;
                      });
                      if (_validUsername() == true) {
                        await _addUser();
                        Navigator.of(context).pop();
                      } else {
                        showMessage("Username already exists!");
                      }
                      _newUsernameController.text = '';
                      _newPasswordController.text = '';
                    },
                    child: const Text('Sign Up'),
                  )
                ],
              ),
            ));
  }

  Future<void> _addUser() async {
    globals.user_id = await SQLHelper.createUser(usernameValue, passwordValue);
    showMessage(_newUsernameController.text + " has signed up!");
    _newUsernameController.text = '';
    _newPasswordController.text = '';
  }

  Future<void> _checkCredentials() async {
    var user = await SQLHelper.getUserByUsername(_usernameController.text);

    if (user.isEmpty) {
      showMessage("User not found");
      _usernameController.text = '';
      _passwordController.text = '';
      return;
    }

    if (user[0]['password'] != _passwordController.text) {
      showMessage("Invalid Credentials");
    } else {
      globals.user_id = user[0]['userId'];
      showMessage("Welcome back ${_usernameController.text}!");
    }

    _usernameController.text = '';
    _passwordController.text = '';
  }

  Future<bool> _validUsername() async {
    bool valid = false;
    var test = await SQLHelper.getUserByUsername(_usernameController.text);
    if (test.isEmpty) valid = true;
    return valid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'CaliWeather',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  usernameValue = _usernameController.text;
                  passwordValue = _passwordController.text;
                });
                await _checkCredentials();
                _usernameController.text = '';
                _passwordController.text = '';
                FocusScope.of(context).unfocus();
              },
              child: const Text('Sign In'),
            ),
          ),
          // This container is for database testing purposes only
          const SizedBox(height: 10),
          Container(
            width: 75,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(
                  width: 3,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Column(
              children: [
                const SizedBox(height: 8),
                Text('ID: ' + globals.user_id.toString(),
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.black)),
              ],
            )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add_alt_1_rounded),
        onPressed: () => _showForm(),
      ),
    );
  }
}
