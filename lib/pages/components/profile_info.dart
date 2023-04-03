import 'package:flutter/material.dart';
import 'package:caliweather/pages/profile.dart';
import 'package:caliweather/util/sql_helper.dart';
import 'package:caliweather/util/sharedprefutil.dart';
import 'package:caliweather/pages/components/header_login_profile.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  String? firstNameValue;
  String? lastNameValue;
  String? usernameValue;
  String? passwordValue;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

  void _updateForm() async {
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
                    controller: _firstNameController,
                    decoration: const InputDecoration(hintText: 'First Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(hintText: 'Last Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(hintText: 'Username'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(hintText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        firstNameValue = _firstNameController.text;
                        lastNameValue = _lastNameController.text;
                        usernameValue = _usernameController.text;
                        passwordValue = _passwordController.text;
                      });
                      await _updateUser();
                      if (context.mounted) {
                        Navigator.of(context, rootNavigator: true).pop(context);
                      }
                      showMessage("You've successfully updated your info!");
                    },
                    child: const Text('Update'),
                  )
                ],
              ),
            ));
  }

  Future<void> _updateUser() async {
    int userId = SharedPrefUtil.getUserId();

    if (firstNameValue == '') {
      firstNameValue = SharedPrefUtil.getUserFirstName();
    }

    if (lastNameValue == '') {
      lastNameValue = SharedPrefUtil.getUserLastName();
    }

    if (usernameValue == '') {
      usernameValue = SharedPrefUtil.getUsername();
    }

    if (passwordValue == '') {
      passwordValue = SharedPrefUtil.getPassword();
    }

    SQLHelper.updateUser(
        firstNameValue, lastNameValue, usernameValue, passwordValue, userId);
    SharedPrefUtil.setUserFirstName(firstNameValue!);
    SharedPrefUtil.setUserLastName(lastNameValue!);
    SharedPrefUtil.setUsername(usernameValue!);
    SharedPrefUtil.setPassword(passwordValue!);

    _firstNameController.text = '';
    _lastNameController.text = '';
    _usernameController.text = '';
    _passwordController.text = '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: Center(
        child: Column(children: <Widget>[
          const HeaderLoginProfile(),
          Container(
            width: 350,
            height: 58,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 3,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(30)),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("First Name: ",
                    style: TextStyle(fontSize: 16, color: Colors.black)),
                Text(SharedPrefUtil.getUserFirstName(),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.black)),
              ],
            )),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: 350,
            height: 58,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 3,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(30)),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Last Name: ",
                    style: TextStyle(fontSize: 16, color: Colors.black)),
                Text(SharedPrefUtil.getUserLastName(),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.black)),
              ],
            )),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: 350,
            height: 58,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 3,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(30)),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Username: ",
                    style: TextStyle(fontSize: 16, color: Colors.black)),
                Text(SharedPrefUtil.getUsername(),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.black)),
              ],
            )),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const ProfilePage()));
            },
            child: const Text('Back'),
          ),
          const SizedBox(height: 20),
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
                    'Need to change your info?',
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
                    onTap: _updateForm,
                    child: const Text(
                      'Update here',
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
        ]),
      )),
    );
  }
}
