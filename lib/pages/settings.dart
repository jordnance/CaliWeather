import '../util/sql_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});
  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

enum LanguageSet { english, spanish }

enum FontSet { small, medium, large }

enum AlertSet { water, energy, api }

enum TempSet { fahrenheit, celsius }

enum ThemeSet { dark, light }

class _SettingsPageState extends State<SettingsPage> {
  bool isVisible = false;
  LanguageSet? _languageSet = LanguageSet.english;
  FontSet? _fontSet = FontSet.small;
  AlertSet? _alertSet = AlertSet.energy;
  TempSet? _tempSet = TempSet.fahrenheit;
  ThemeSet? _themeSet = ThemeSet.light;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(280, 40),
              primary: Colors.grey,
              onPrimary: Colors.black,
            ),
            child: const Text('Set Language'),
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            }),
        Visibility(
            visible: isVisible,
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
                          });
                        })),
              ],
            )),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(280, 40),
            primary: Colors.grey,
            onPrimary: Colors.black,
          ),
          child: const Text('Set Font Size'),
          onPressed: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
        ),
        Visibility(
            visible: isVisible,
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
                          });
                        })),
                Expanded(
                    child: RadioListTile(
                        title: const Text('Medium'),
                        value: FontSet.medium,
                        groupValue: _fontSet,
                        onChanged: (FontSet? value) {
                          setState(() {
                            _fontSet = value;
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
                          });
                        })),
              ],
            )),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(280, 40),
            primary: Colors.grey,
            onPrimary: Colors.black,
          ),
          child: const Text('Set Location'),
          onPressed: () {},
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(280, 40),
            primary: Colors.grey,
            onPrimary: Colors.black,
          ),
          child: const Text('Set Alerts'),
          onPressed: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
        ),
        Visibility(
            visible: isVisible,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: RadioListTile(
                        title: const Text('Conserve Energy'),
                        value: AlertSet.energy,
                        groupValue: _alertSet,
                        onChanged: (AlertSet? value) {
                          setState(() {
                            _alertSet = value;
                          });
                        })),
                Expanded(
                    child: RadioListTile(
                        title: const Text('Conserve Water'),
                        value: AlertSet.water,
                        groupValue: _alertSet,
                        onChanged: (AlertSet? value) {
                          setState(() {
                            _alertSet = value;
                          });
                        })),
                Expanded(
                    child: RadioListTile(
                        title: const Text('API Related'),
                        value: AlertSet.api,
                        groupValue: _alertSet,
                        onChanged: (AlertSet? value) {
                          setState(() {
                            _alertSet = value;
                          });
                        })),
              ],
            )),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(280, 40),
            primary: Colors.grey,
            onPrimary: Colors.black,
          ),
          child: const Text('Set °F or °C'),
          onPressed: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
        ),
        Visibility(
            visible: isVisible,
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
                          });
                        })),
              ],
            )),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(280, 40),
            primary: Colors.grey,
            onPrimary: Colors.black,
          ),
          child: const Text('Theme Toggle'),
          onPressed: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
        ),
        Visibility(
            visible: isVisible,
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
                          });
                        })),
              ],
            )),
      ],
    ));
  }
}
