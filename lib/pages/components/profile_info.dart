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
  String? currentPasswordValue;
  String? newPasswordValue;
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _firstNameController =
      TextEditingController(text: SharedPrefUtil.getUserFirstName());
  final TextEditingController _lastNameController =
      TextEditingController(text: SharedPrefUtil.getUserLastName());
  final TextEditingController _usernameController =
      TextEditingController(text: SharedPrefUtil.getUsername());

  InputDecoration? currentBoxDecoration;
  TextStyle? currentTextStyle;

  final TextStyle _editingOnTextStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

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
              controller: _currentPasswordController,
              decoration: const InputDecoration(hintText: 'First Name'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _newPasswordController,
              decoration: const InputDecoration(hintText: 'Last Name'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _newPasswordController,
              decoration: const InputDecoration(hintText: 'Username'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  newPasswordValue = _newPasswordController.text;
                });
                await _updatePassword();
                if (context.mounted) {
                  Navigator.of(context, rootNavigator: true).pop(context);
                }
                showMessage("Password changed!");
              },
              child: const Text('Update'),
            )
          ],
        ),
      ),
    );
  }

  void _editProfileShowModul() async {
    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
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
            const Center(
              child: Text(
                "Update Profile",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Divider(
                thickness: 0.5,
                color: Colors.grey[600],
              ),
            ),
            Container(
              width: 350,
              height: 58,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1.5,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        "First Name: ",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 40.0),
                        child: SizedBox(
                          height: 24,
                          child: TextField(
                            controller: _firstNameController,
                            enabled: true,
                            readOnly: false,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.mode_edit_outline,
                                size: 16,
                              ),
                            ),
                            textAlign: TextAlign.center,
                            style: _editingOnTextStyle,
                            onTapOutside: (_) {
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 350,
              height: 58,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1.5,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Last Name: ",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 40.0),
                        child: SizedBox(
                          height: 24,
                          child: TextField(
                            controller: _lastNameController,
                            enabled: true,
                            readOnly: false,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.mode_edit_outline,
                                size: 16,
                              ),
                            ),
                            textAlign: TextAlign.center,
                            style: _editingOnTextStyle,
                            onTapOutside: (_) {
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 350,
              height: 58,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1.5,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Username: ",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 40.0),
                        child: SizedBox(
                          height: 24,
                          child: TextField(
                            controller: _usernameController,
                            enabled: true,
                            readOnly: false,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.mode_edit_outline,
                                size: 16,
                              ),
                            ),
                            textAlign: TextAlign.center,
                            style: _editingOnTextStyle,
                            onTapOutside: (_) {
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 96, 96, 96),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _firstNameController.text =
                          SharedPrefUtil.getUserFirstName();
                      _lastNameController.text =
                          SharedPrefUtil.getUserLastName();
                      _usernameController.text = SharedPrefUtil.getUsername();
                    });
                    Navigator.of(context, rootNavigator: true).pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 83, 129),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      newPasswordValue = _newPasswordController.text;
                    });
                    await _updateProfileInfo();
                    if (context.mounted) {
                      Navigator.of(context, rootNavigator: true).pop(context);
                    }
                    showMessage("Profile Updated!");
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateProfileInfo() async {
    int userId = SharedPrefUtil.getUserId();
    String password = SharedPrefUtil.getPassword();
    SQLHelper.updateUser(
      _firstNameController.text,
      _lastNameController.text,
      _usernameController.text,
      password,
      userId,
    );
    SharedPrefUtil.setUserFirstName(_firstNameController.text);
    SharedPrefUtil.setUserLastName(_lastNameController.text);
    SharedPrefUtil.setUsername(_usernameController.text);
    setState(() {});
  }

  Future<void> _updatePassword() async {
    String password = _newPasswordController.text;
    SQLHelper.updatePassword(
      _usernameController.text,
      password,
    );
    SharedPrefUtil.setPassword(password);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              const HeaderLoginProfile(),
              Container(
                width: 350,
                height: 58,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 1.5,
                      color: Colors.grey.shade600,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          "First Name: ",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          SharedPrefUtil.getUserFirstName(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                      width: 1.5,
                      color: Colors.grey.shade600,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Last Name: ",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          SharedPrefUtil.getUserLastName(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                      width: 1.5,
                      color: Colors.grey.shade600,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Username: ",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          SharedPrefUtil.getUsername(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 83, 129),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ProfilePage()));
                    },
                    child: const Text('Back'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 96, 96, 96),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () async {
                      SharedPrefUtil.checkAllPrefs();
                    },
                    child: const Text('Test'),
                  ),
                ],
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
                      child: InkWell(
                        onTap: _editProfileShowModul,
                        child: const Text(
                          'Edit Profile Info',
                          style: TextStyle(
                              color: Color.fromARGB(255, 18, 108, 181),
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      '  ||  ',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: InkWell(
                        onTap: _updateForm,
                        child: const Text(
                          'Reset Password',
                          style: TextStyle(
                            color: Color.fromARGB(255, 18, 108, 181),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//   Widget build(BuildContext context) {
//     if (_editingEnabled) {
//       currentBoxDecoration = _editingOnBoxDecoration;
//       currentTextStyle = _editingOnTextStyle;
//     } else {
//       currentBoxDecoration = _editingOffBoxDecoration;
//       currentTextStyle = _editingOffTextStyle;
//     }
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               const HeaderLoginProfile(),
//               Container(
//                 width: 350,
//                 height: 58,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(
//                       width: 1.5,
//                       color: Colors.black,
//                     ),
//                     borderRadius: BorderRadius.circular(30)),
//                 child: Center(
//                   child: Row(
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(left: 20.0),
//                         child: Text(
//                           "First Name: ",
//                           style: TextStyle(fontSize: 16, color: Colors.black),
//                           textAlign: TextAlign.left,
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding:
//                               const EdgeInsets.only(left: 10.0, right: 40.0),
//                           child: SizedBox(
//                             height: 48,
//                             child: TextField(
//                               controller: _firstNameController,
//                               enabled: _editingEnabled,
//                               readOnly: !_editingEnabled,
//                               decoration: currentBoxDecoration,
//                               textAlign: TextAlign.center,
//                               style: currentTextStyle,
//                               // onTapOutside: (_) {
//                               //   FocusScope.of(context)
//                               //       .requestFocus(FocusNode());
//                               // },
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               Container(
//                 width: 350,
//                 height: 58,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(
//                       width: 1.5,
//                       color: Colors.black,
//                     ),
//                     borderRadius: BorderRadius.circular(30)),
//                 child: Center(
//                   child: Row(
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(left: 20.0),
//                         child: Text(
//                           "Last Name: ",
//                           style: TextStyle(fontSize: 16, color: Colors.black),
//                           textAlign: TextAlign.left,
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding:
//                               const EdgeInsets.only(left: 10.0, right: 40.0),
//                           child: SizedBox(
//                             height: 48,
//                             child: TextField(
//                               controller: _lastNameController,
//                               enabled: _editingEnabled,
//                               readOnly: !_editingEnabled,
//                               decoration: currentBoxDecoration,
//                               textAlign: TextAlign.center,
//                               style: currentTextStyle,
//                               // onTapOutside: (_) {
//                               //   FocusScope.of(context)
//                               //       .requestFocus(FocusNode());
//                               // },
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               Container(
//                 width: 350,
//                 height: 58,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(
//                       width: 1.5,
//                       color: Colors.black,
//                     ),
//                     borderRadius: BorderRadius.circular(30)),
//                 child: Center(
//                   child: Row(
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(left: 20.0),
//                         child: Text(
//                           "Username: ",
//                           style: TextStyle(fontSize: 16, color: Colors.black),
//                           textAlign: TextAlign.left,
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding:
//                               const EdgeInsets.only(left: 10.0, right: 40.0),
//                           child: SizedBox(
//                             height: 48,
//                             child: TextField(
//                               controller: _usernameController,
//                               enabled: _editingEnabled,
//                               readOnly: !_editingEnabled,
//                               decoration: currentBoxDecoration,
//                               textAlign: TextAlign.center,
//                               style: currentTextStyle,
//                               // onTapOutside: (_) {
//                               //   FocusScope.of(context)
//                               //       .requestFocus(FocusNode());
//                               // },
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 15),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Visibility(
              //       visible: !_editingEnabled,
              //       child: Row(
              //         children: [
              //           ElevatedButton(
              //             child: const Text('Back'),
              //             style: ElevatedButton.styleFrom(
              //               backgroundColor:
              //                   const Color.fromARGB(255, 96, 96, 96),
              //               textStyle: const TextStyle(
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             onPressed: () async {
              //               Navigator.of(context).pushReplacement(
              //                   MaterialPageRoute(
              //                       builder: (BuildContext context) =>
              //                           const ProfilePage()));
              //             },
              //           ),

              //           // TODO: remove after testing is done
              //           SizedBox(width: 4),
              //           ElevatedButton(
              //             child: const Text('Test'),
              //             style: ElevatedButton.styleFrom(
              //               backgroundColor:
              //                   const Color.fromARGB(255, 0, 83, 129),
              //               textStyle: const TextStyle(
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             onPressed: () async {
              //               SharedPrefUtil.checkAllPrefs();
              //             },
              //           ),
              //         ],
              //       ),
              //     ),
//                   Visibility(
//                     visible: _editingEnabled,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                       child: ElevatedButton(
//                         child: const Text('Cancel'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color.fromARGB(255, 96, 96, 96),
//                           textStyle: const TextStyle(
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _firstNameController.text =
//                                 SharedPrefUtil.getUserFirstName();
//                             _lastNameController.text =
//                                 SharedPrefUtil.getUserLastName();
//                             _usernameController.text =
//                                 SharedPrefUtil.getUsername();
//                             _editingEnabled = false;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                   Visibility(
//                     visible: _editingEnabled,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                       child: ElevatedButton(
//                         child: const Text('Save'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor:
//                               const Color.fromARGB(255, 0, 83, 129),
//                           textStyle: const TextStyle(
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _updateProfileInfo();
//                             _editingEnabled = false;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Visibility(
//                 visible: !_editingEnabled,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: Divider(
//                           thickness: 0.5,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(left: 12.0),
//                         child: InkWell(
//                           onTap: _updateForm2,
//                           // onTap: () {
//                           //   setState(() {
//                           //     _editingEnabled = true;
//                           //   });
//                           // },
//                           child: Text(
//                             'Edit Profile Info',
//                             style: TextStyle(
//                                 color: Colors.blueGrey,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w400),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 7),
//                       Text(
//                         '  ||  ',
//                         style: TextStyle(
//                           color: Colors.grey[700],
//                           fontSize: 13,
//                           fontWeight: FontWeight.w900,
//                         ),
//                       ),
//                       const SizedBox(width: 3),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 12.0),
//                         child: InkWell(
//                           onTap: _updateForm,
//                           child: Text(
//                             'Reset Password',
//                             style: TextStyle(
//                               color: Colors.blueGrey,
//                               fontSize: 13,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Divider(
//                           thickness: 0.5,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Visibility(
//                 visible: _editingEnabled,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: Divider(
//                           thickness: 0.5,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 12.0),
//                         child: Text(
//                           'Update password?',
//                           style: TextStyle(
//                             color: Colors.grey[700],
//                             fontSize: 13,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 3),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 12.0),
//                         child: InkWell(
//                           onTap: _updateForm,
//                           child: const Text(
//                             'Click here',
//                             style: TextStyle(
//                               color: Colors.blue,
//                               fontSize: 13,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Divider(
//                           thickness: 0.5,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
