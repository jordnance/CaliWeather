import '../util/sql_helper.dart';
import '../util/sharedprefutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:dropdown_button2/dropdown_button2.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});
  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

enum LanguageSet { english, spanish }

enum FontSet { small, medium, large }

enum ConserveEnergy { on, off }

enum ConserveWater { on, off }

enum ApiRelated { on, off }

enum TempSet { fahrenheit, celsius }

enum ThemeSet { dark, light }

class _SettingsPageState extends State<SettingsPage> {
  bool isVisibleLang = false;
  bool isVisibleFont = false;
  bool isVisibleAlert = false;
  bool isVisibleTemp = false;
  bool isVisibleTheme = false;
  bool isVisibleLocation = false;
  bool checkboxEnergy = false;
  bool checkboxAPI = false;
  bool checkboxWater = false;
  bool isSaved = false;
  String? usernameValue;

  LanguageSet? _languageSet = LanguageSet.english;
  FontSet? _fontSet = FontSet.small;
  TempSet? _tempSet = TempSet.fahrenheit;
  ThemeSet? _themeSet = ThemeSet.light;
  ConserveEnergy? _alertEnergy = ConserveEnergy.off;
  ConserveWater? _alertWater = ConserveWater.off;
  ApiRelated? _alertAPI = ApiRelated.off;

  @override
  void initState() {
    super.initState();
    if (SharedPrefUtil.getUsername() != '') {
      usernameValue = SharedPrefUtil.getUsername();
    }
    SharedPrefUtil.setLanguage(_languageSet.toString().split('.').last);
    SharedPrefUtil.setFontSize(_fontSet.toString().split('.').last);
    SharedPrefUtil.setFontSize(_fontSet.toString().split('.').last);
    SharedPrefUtil.setConserveEnergy(_alertEnergy.toString().split('.').last);
    SharedPrefUtil.setConserveWater(_alertWater.toString().split('.').last);
    SharedPrefUtil.setApiRelated(_alertAPI.toString().split('.').last);
    SharedPrefUtil.setTempFormat(_tempSet.toString().split('.').last);
    SharedPrefUtil.setTheme(_themeSet.toString().split('.').last);
    SharedPrefUtil.checkAllPrefs();
  }

  Future<void> _showSaveAlert() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Save Confirmation'),
            content: SingleChildScrollView(
                child: Column(
              children: const <Widget>[
                Text('Are you sure you want to save?'),
              ],
            )),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  saveSettings();
                  Navigator.of(context).pop();
                },
                child: const Text('Confirm'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              )
            ],
          );
        });
  }

  void saveSettings() async {
    var user = await SQLHelper.getUserByUsername(usernameValue);
    var prefUserId = user[0]['userId'];
    var lang = _languageSet.toString().split('.').last;
    var fSize = _fontSet.toString().split('.').last;
    var conEnergy = _alertEnergy.toString().split('.').last;
    var conWater = _alertWater.toString().split('.').last;
    var apiRel = _alertAPI.toString().split('.').last;
    var temp = _tempSet.toString().split('.').last;
    var theme = _themeSet.toString().split('.').last;

    if (isSaved) {
      await SQLHelper.updateLang(prefUserId, lang);
      await SQLHelper.updateSize(prefUserId, fSize);
      await SQLHelper.updateAlerts(prefUserId, conEnergy, conWater, apiRel);
      await SQLHelper.updateTemp(prefUserId, temp);
      await SQLHelper.updateTheme(prefUserId, theme);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool darkTheme = false;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Developer')),
      child: SafeArea(
        bottom: false,
        child: SettingsList(
          applicationType: ApplicationType.cupertino,
          platform: DevicePlatform.iOS,
          sections: [
            SettingsSection(
              title: Text('APPEARANCE'),
              tiles: [
                SettingsTile.switchTile(
                  onToggle: (value) {
                    setState(() {
                      darkTheme = value;
                    });
                  },
                  initialValue: darkTheme,
                  title: Text('Enable Dark Theme'),
                ),
              ],
            ),
            SettingsSection(
              title: Text('DISPLAY ZOOM'),
              tiles: [
                SettingsTile.navigation(
                  onPressed: (_) {},
                  title: Text('View'),
                  value: Text('Standard'),
                  description: Text(
                    'Choose a view for iPhone. '
                    'Zoomed shadows larger controls. '
                    'Standart shows more content.',
                  ),
                ),
              ],
            ),
            SettingsSection(
              title: Text('UI AUTOMATION'),
              tiles: [
                SettingsTile.switchTile(
                  onToggle: (_) {},
                  initialValue: true,
                  title: Text('Enable UI Automation'),
                ),
                SettingsTile.navigation(
                  title: Text('Multipath Networking'),
                ),
                SettingsTile.switchTile(
                  onToggle: (_) {},
                  initialValue: false,
                  title: Text('HTTP/3'),
                ),
              ],
            ),
            SettingsSection(
              title: Text('STATE RESTORATION TESTING'),
              tiles: [
                SettingsTile.switchTile(
                  onToggle: (_) {},
                  initialValue: false,
                  title: Text(
                    'Fast App Termination',
                  ),
                  description: Text(
                    'Terminate instead of suspending apps when backgrounded to '
                    'force apps to be relaunched when tray '
                    'are foregrounded.',
                  ),
                ),
              ],
            ),
            SettingsSection(
              title: Text('IAD DEVELOPER APP TESTING'),
              tiles: [
                SettingsTile.navigation(
                  title: Text('Fill Rate'),
                ),
                SettingsTile.navigation(
                  title: Text('Add Refresh Rate'),
                ),
                SettingsTile.switchTile(
                  onToggle: (_) {},
                  initialValue: false,
                  title: Text('Unlimited Ad Presentation'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    // return Scaffold(
    //     body: Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       ElevatedButton(
    //           style: ElevatedButton.styleFrom(
    //             foregroundColor: Colors.black,
    //             backgroundColor: Colors.grey,
    //             minimumSize: const Size(280, 40),
    //           ),
    //           child: const Text('Set Language'),
    //           onPressed: () {
    //             setState(() {
    //               isVisibleLang = !isVisibleLang;
    //             });
    //           }),
    //       Visibility(
    //           visible: isVisibleLang,
    //           child: Row(
    //             children: <Widget>[
    //               Expanded(
    //                   child: RadioListTile(
    //                       title: const Text('English'),
    //                       value: LanguageSet.english,
    //                       groupValue: _languageSet,
    //                       onChanged: (LanguageSet? value) {
    //                         setState(() {
    //                           _languageSet = value;
    //                           SharedPrefUtil.setLanguage(
    //                               _languageSet.toString().split('.').last);
    //                           SharedPrefUtil.checkAllPrefs();
    //                         });
    //                       })),
    //               Expanded(
    //                   child: RadioListTile(
    //                       title: const Text('Spanish'),
    //                       value: LanguageSet.spanish,
    //                       groupValue: _languageSet,
    //                       onChanged: (LanguageSet? value) {
    //                         setState(() {
    //                           _languageSet = value;
    //                           SharedPrefUtil.setLanguage(
    //                               _languageSet.toString().split('.').last);
    //                           SharedPrefUtil.checkAllPrefs();
    //                         });
    //                       })),
    //             ],
    //           )),
    //       ElevatedButton(
    //         style: ElevatedButton.styleFrom(
    //           foregroundColor: Colors.black,
    //           backgroundColor: Colors.grey,
    //           minimumSize: const Size(280, 40),
    //         ),
    //         child: const Text('Set Font Size'),
    //         onPressed: () {
    //           setState(() {
    //             isVisibleFont = !isVisibleFont;
    //           });
    //         },
    //       ),
    //       Visibility(
    //           visible: isVisibleFont,
    //           child: Row(
    //             children: <Widget>[
    //               Expanded(
    //                   child: RadioListTile(
    //                       title: const Text('Small'),
    //                       value: FontSet.small,
    //                       groupValue: _fontSet,
    //                       onChanged: (FontSet? value) {
    //                         setState(() {
    //                           _fontSet = value;
    //                           SharedPrefUtil.setFontSize(
    //                               _fontSet.toString().split('.').last);
    //                           SharedPrefUtil.checkAllPrefs();
    //                         });
    //                       })),
    //               Expanded(
    //                   child: RadioListTile(
    //                       title: const Text('Medium',
    //                           style: TextStyle(
    //                             fontSize: 11.5,
    //                           )),
    //                       value: FontSet.medium,
    //                       groupValue: _fontSet,
    //                       onChanged: (FontSet? value) {
    //                         setState(() {
    //                           _fontSet = value;
    //                           SharedPrefUtil.setFontSize(
    //                               _fontSet.toString().split('.').last);
    //                           SharedPrefUtil.checkAllPrefs();
    //                         });
    //                       })),
    //               Expanded(
    //                   child: RadioListTile(
    //                       title: const Text('Large'),
    //                       value: FontSet.large,
    //                       groupValue: _fontSet,
    //                       onChanged: (FontSet? value) {
    //                         setState(() {
    //                           _fontSet = value;
    //                           SharedPrefUtil.setFontSize(
    //                               _fontSet.toString().split('.').last);
    //                           SharedPrefUtil.checkAllPrefs();
    //                         });
    //                       })),
    //             ],
    //           )),
    //       ElevatedButton(
    //         style: ElevatedButton.styleFrom(
    //           foregroundColor: Colors.black,
    //           backgroundColor: Colors.grey,
    //           minimumSize: const Size(280, 40),
    //         ),
    //         child: const Text('Set Location'),
    //         onPressed: () {
    //           setState(() {
    //             isVisibleLocation = !isVisibleLocation;
    //           });
    //         },
    //       ),
    //       ElevatedButton(
    //         style: ElevatedButton.styleFrom(
    //           foregroundColor: Colors.black,
    //           backgroundColor: Colors.grey,
    //           minimumSize: const Size(280, 40),
    //         ),
    //         child: const Text('Set Alerts'),
    //         onPressed: () {
    //           setState(() {
    //             isVisibleAlert = !isVisibleAlert;
    //           });
    //         },
    //       ),
    //       Visibility(
    //           visible: isVisibleAlert,
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: <Widget>[
    //               Flexible(
    //                 fit: FlexFit.loose,
    //                 child: CheckboxListTile(
    //                   title: const Text('Conserve Energy'),
    //                   checkColor: Colors.white,
    //                   value: checkboxEnergy,
    //                   onChanged: (bool? value) {
    //                     setState(() {
    //                       checkboxEnergy = value!;
    //                       if (checkboxEnergy == true) {
    //                         _alertEnergy = ConserveEnergy.on;
    //                         SharedPrefUtil.setConserveEnergy(
    //                             _alertEnergy.toString().split('.').last);
    //                       } else {
    //                         _alertEnergy = ConserveEnergy.off;
    //                         SharedPrefUtil.setConserveEnergy(
    //                             _alertEnergy.toString().split('.').last);
    //                       }
    //                     });
    //                   },
    //                 ),
    //               ),
    //               Flexible(
    //                   fit: FlexFit.loose,
    //                   child: CheckboxListTile(
    //                     title: const Text('Conserve Water'),
    //                     checkColor: Colors.white,
    //                     value: checkboxWater,
    //                     onChanged: (bool? value) {
    //                       setState(() {
    //                         checkboxWater = value!;
    //                         if (checkboxWater == true) {
    //                           _alertWater = ConserveWater.on;
    //                           SharedPrefUtil.setConserveWater(
    //                               _alertWater.toString().split('.').last);
    //                         } else {
    //                           _alertWater = ConserveWater.off;
    //                           SharedPrefUtil.setConserveWater(
    //                               _alertWater.toString().split('.').last);
    //                         }
    //                       });
    //                     },
    //                   )),
    //               Flexible(
    //                 fit: FlexFit.loose,
    //                 child: CheckboxListTile(
    //                   title: const Text('API Related'),
    //                   checkColor: Colors.white,
    //                   value: checkboxAPI,
    //                   onChanged: (bool? value) {
    //                     setState(() {
    //                       checkboxAPI = value!;
    //                       if (checkboxAPI == true) {
    //                         _alertAPI = ApiRelated.on;
    //                         SharedPrefUtil.setApiRelated(
    //                             _alertAPI.toString().split('.').last);
    //                       } else {
    //                         _alertAPI = ApiRelated.off;
    //                         SharedPrefUtil.setApiRelated(
    //                             _alertAPI.toString().split('.').last);
    //                       }
    //                     });
    //                   },
    //                 ),
    //               )
    //             ],
    //           )),
    //       ElevatedButton(
    //         style: ElevatedButton.styleFrom(
    //           foregroundColor: Colors.black,
    //           backgroundColor: Colors.grey,
    //           minimumSize: const Size(280, 40),
    //         ),
    //         child: const Text('Set °F or °C'),
    //         onPressed: () {
    //           setState(() {
    //             isVisibleTemp = !isVisibleTemp;
    //           });
    //         },
    //       ),
    //       Visibility(
    //           visible: isVisibleTemp,
    //           child: Row(
    //             children: <Widget>[
    //               Expanded(
    //                   child: RadioListTile(
    //                       title: const Text('Fahrenheit'),
    //                       value: TempSet.fahrenheit,
    //                       groupValue: _tempSet,
    //                       onChanged: (TempSet? value) {
    //                         setState(() {
    //                           _tempSet = value;
    //                           SharedPrefUtil.setTempFormat(
    //                               _tempSet.toString().split('.').last);
    //                           SharedPrefUtil.checkAllPrefs();
    //                         });
    //                       })),
    //               Expanded(
    //                   child: RadioListTile(
    //                       title: const Text('Celsius'),
    //                       value: TempSet.celsius,
    //                       groupValue: _tempSet,
    //                       onChanged: (TempSet? value) {
    //                         setState(() {
    //                           _tempSet = value;
    //                           SharedPrefUtil.setTempFormat(
    //                               _tempSet.toString().split('.').last);
    //                           SharedPrefUtil.checkAllPrefs();
    //                         });
    //                       })),
    //             ],
    //           )),
    //       ElevatedButton(
    //         style: ElevatedButton.styleFrom(
    //           foregroundColor: Colors.black,
    //           backgroundColor: Colors.grey,
    //           minimumSize: const Size(280, 40),
    //         ),
    //         child: const Text('Theme Toggle'),
    //         onPressed: () {
    //           setState(() {
    //             isVisibleTheme = !isVisibleTheme;
    //           });
    //         },
    //       ),
    //       Visibility(
    //           visible: isVisibleTheme,
    //           child: Row(
    //             children: <Widget>[
    //               Expanded(
    //                   child: RadioListTile(
    //                       title: const Text('Light Mode'),
    //                       value: ThemeSet.light,
    //                       groupValue: _themeSet,
    //                       onChanged: (ThemeSet? value) {
    //                         setState(() {
    //                           _themeSet = value;
    //                           SharedPrefUtil.setTheme(
    //                               _themeSet.toString().split('.').last);
    //                           SharedPrefUtil.checkAllPrefs();
    //                         });
    //                       })),
    //               Expanded(
    //                   child: RadioListTile(
    //                       title: const Text('Dark Mode'),
    //                       value: ThemeSet.dark,
    //                       groupValue: _themeSet,
    //                       onChanged: (ThemeSet? value) {
    //                         setState(() {
    //                           _themeSet = value;
    //                           SharedPrefUtil.setTempFormat(
    //                               _themeSet.toString().split('.').last);
    //                           SharedPrefUtil.checkAllPrefs();
    //                         });
    //                       })),
    //             ],
    //           )),
    //       ElevatedButton(
    //           style: ElevatedButton.styleFrom(
    //             foregroundColor: Colors.black,
    //             backgroundColor: Colors.blue,
    //             minimumSize: const Size(280, 40),
    //           ),
    //           child: const Text('Save'),
    //           onPressed: () async {
    //             setState(() {
    //               isSaved = !isSaved;
    //             });
    //             _showSaveAlert();
    //           })
    //     ],
    //   ),
    // ));
  }
}
