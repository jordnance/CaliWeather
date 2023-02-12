import 'sql_helper.dart';
import 'globals.dart' as globals;
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;

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
  final TextEditingController _newUsernameController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  void showMessage(String message) {
    if (mounted) {
      setState(() {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(message)));
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
                      await _addUser();
                      _newUsernameController.text = '';
                      _newPasswordController.text = '';
                      Navigator.of(context).pop();
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

  Future<void> _findUser() async {
    var test = await SQLHelper.getUser(
        _usernameController.text, _passwordController.text);
    if (test.isEmpty) {
      showMessage(_usernameController.text + " has not signed up");
    } else {
      globals.user_id = test[0]['userId'];
      showMessage(_usernameController.text + " has signed in!");
    }
    _usernameController.text = '';
    _passwordController.text = '';
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
                await _findUser();
                _usernameController.text = '';
                _passwordController.text = '';
                FocusScope.of(context).unfocus();
              },
              child: const Text('Sign In'),
            ),
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
