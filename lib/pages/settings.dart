import 'package:caliweather/main.dart';

import '../util/sql_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import '../util/sharedprefutil.dart';

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

  LanguageSet? _languageSet = LanguageSet.english;
  FontSet? _fontSet = FontSet.small;
  TempSet? _tempSet = TempSet.fahrenheit;
  ThemeSet? _themeSet = ThemeSet.light;
  ConserveEnergy _alertEnergy = ConserveEnergy.off;
  ConserveWater? _alertWater = ConserveWater.off;
  ApiRelated? _alertAPI = ApiRelated.off;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.grey,
                minimumSize: const Size(280, 40),
              ),
              child: const Text('Set Language'),
              onPressed: () {
                setState(() {
                  isVisibleLang = !isVisibleLang;
                });
              }),
          Visibility(
              visible: isVisibleLang,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: RadioListTile(
                          title: const Text('English'),
                          value: LanguageSet.english,
                          groupValue: _languageSet,
                          onChanged: (LanguageSet? value) {
                            setState(() {
                              _languageSet = value;
                              SharedPrefUtil.setLanguage(
                                  _languageSet.toString().split('.').last);
                              SharedPrefUtil.checkAllPrefs();
                            });
                          })),
                  Expanded(
                      child: RadioListTile(
                          title: const Text('Spanish'),
                          value: LanguageSet.spanish,
                          groupValue: _languageSet,
                          onChanged: (LanguageSet? value) {
                            setState(() {
                              _languageSet = value;
                              SharedPrefUtil.setLanguage(
                                  _languageSet.toString().split('.').last);
                              SharedPrefUtil.checkAllPrefs();
                            });
                          })),
                ],
              )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.grey,
              minimumSize: const Size(280, 40),
            ),
            child: const Text('Set Font Size'),
            onPressed: () {
              setState(() {
                isVisibleFont = !isVisibleFont;
              });
            },
          ),
          Visibility(
              visible: isVisibleFont,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: RadioListTile(
                          title: const Text('Small'),
                          value: FontSet.small,
                          groupValue: _fontSet,
                          onChanged: (FontSet? value) {
                            setState(() {
                              _fontSet = value;
                              SharedPrefUtil.setFontSize(
                                  _fontSet.toString().split('.').last);
                              SharedPrefUtil.checkAllPrefs();
                            });
                          })),
                  Expanded(
                      child: RadioListTile(
                          title: const Text('Medium',
                              style: TextStyle(
                                fontSize: 11.5,
                              )),
                          value: FontSet.medium,
                          groupValue: _fontSet,
                          onChanged: (FontSet? value) {
                            setState(() {
                              _fontSet = value;
                              SharedPrefUtil.setFontSize(
                                  _fontSet.toString().split('.').last);
                              SharedPrefUtil.checkAllPrefs();
                            });
                          })),
                  Expanded(
                      child: RadioListTile(
                          title: const Text('Large'),
                          value: FontSet.large,
                          groupValue: _fontSet,
                          onChanged: (FontSet? value) {
                            setState(() {
                              _fontSet = value;
                              SharedPrefUtil.setFontSize(
                                  _fontSet.toString().split('.').last);
                              SharedPrefUtil.checkAllPrefs();
                            });
                          })),
                ],
              )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.grey,
              minimumSize: const Size(280, 40),
            ),
            child: const Text('Set Location'),
            onPressed: () {
              setState(() {
                isVisibleLocation = !isVisibleLocation;
              });
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.grey,
              minimumSize: const Size(280, 40),
            ),
            child: const Text('Set Alerts'),
            onPressed: () {
              setState(() {
                isVisibleAlert = !isVisibleAlert;
              });
            },
          ),
          Visibility(
              visible: isVisibleAlert,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.loose,
                    child: CheckboxListTile(
                      title: const Text('Conserve Energy'),
                      checkColor: Colors.white,
                      value: checkboxEnergy,
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxEnergy = value!;
                        });
                      },
                    ),
                    // RadioListTile(
                    //     title: const Text('Conserve Energy'),
                    //     value: AlertSet.energy,
                    //     groupValue: _alertSet,
                    //     onChanged: (AlertSet? value) {
                    //       setState(() {
                    //         _alertSet = value;
                    //         SharedPrefUtil.setConserveEnergy(
                    //             _alertSet.toString().split('.').last);
                    //         SharedPrefUtil.checkAllPrefs();
                    //       });
                    //     }),
                  ),
                  Flexible(
                      fit: FlexFit.loose,
                      child: CheckboxListTile(
                        title: const Text('Conserve Water'),
                        checkColor: Colors.white,
                        value: checkboxWater,
                        onChanged: (bool? value) {
                          setState(() {
                            checkboxWater = value!;
                          });
                        },
                      )),
                  // child: RadioListTile(
                  //     title: const Text('Conserve Water'),
                  //     value: AlertSet.water,
                  //     groupValue: _alertSet,
                  //     onChanged: (AlertSet? value) {
                  //       setState(() {
                  //         _alertSet = value;
                  //         SharedPrefUtil.setConserveWater(
                  //             _alertSet.toString().split('.').last);
                  //         SharedPrefUtil.checkAllPrefs();
                  //       });
                  //     })),
                  Flexible(
                    fit: FlexFit.loose,
                    child: CheckboxListTile(
                      title: const Text('API Related'),
                      checkColor: Colors.white,
                      value: checkboxAPI,
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxAPI = value!;
                        });
                      },
                    ),
                    // child: RadioListTile(
                    //     title: const Text('API Related'),
                    //     value: AlertSet.api,
                    //     groupValue: _alertSet,
                    //     onChanged: (AlertSet? value) {
                    //       setState(() {
                    //         _alertSet = value;
                    //         SharedPrefUtil.setApiRelated(
                    //             _alertSet.toString().split('.').last);
                    //         SharedPrefUtil.checkAllPrefs();
                    //       });
                    //     })),
                  )
                ],
              )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.grey,
              minimumSize: const Size(280, 40),
            ),
            child: const Text('Set °F or °C'),
            onPressed: () {
              setState(() {
                isVisibleTemp = !isVisibleTemp;
              });
            },
          ),
          Visibility(
              visible: isVisibleTemp,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: RadioListTile(
                          title: const Text('Fahrenheit'),
                          value: TempSet.fahrenheit,
                          groupValue: _tempSet,
                          onChanged: (TempSet? value) {
                            setState(() {
                              _tempSet = value;
                              SharedPrefUtil.setTempFormat(
                                  _tempSet.toString().split('.').last);
                              SharedPrefUtil.checkAllPrefs();
                            });
                          })),
                  Expanded(
                      child: RadioListTile(
                          title: const Text('Celsius'),
                          value: TempSet.celsius,
                          groupValue: _tempSet,
                          onChanged: (TempSet? value) {
                            setState(() {
                              _tempSet = value;
                              SharedPrefUtil.setTempFormat(
                                  _tempSet.toString().split('.').last);
                              SharedPrefUtil.checkAllPrefs();
                            });
                          })),
                ],
              )),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.grey,
              minimumSize: const Size(280, 40),
            ),
            child: const Text('Theme Toggle'),
            onPressed: () {
              setState(() {
                isVisibleTheme = !isVisibleTheme;
              });
            },
          ),
          Visibility(
              visible: isVisibleTheme,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: RadioListTile(
                          title: const Text('Light Mode'),
                          value: ThemeSet.light,
                          groupValue: _themeSet,
                          onChanged: (ThemeSet? value) {
                            setState(() {
                              _themeSet = value;
                              SharedPrefUtil.setTheme(
                                  _themeSet.toString().split('.').last);
                              SharedPrefUtil.checkAllPrefs();
                            });
                          })),
                  Expanded(
                      child: RadioListTile(
                          title: const Text('Dark Mode'),
                          value: ThemeSet.dark,
                          groupValue: _themeSet,
                          onChanged: (ThemeSet? value) {
                            setState(() {
                              _themeSet = value;
                              SharedPrefUtil.setTempFormat(
                                  _themeSet.toString().split('.').last);
                              SharedPrefUtil.checkAllPrefs();
                            });
                          })),
                ],
              )),
        ],
      ),
    ));
  }
}
