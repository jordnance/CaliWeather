import 'dart:math';

import '../util/sql_helper.dart';
import '../util/sharedprefutil.dart';
import '../util/settings_util.dart';
import '../util/weather_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});
  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _enableDarkTheme = false;
  bool _enableEnergyAlerts = false;
  bool _enableApiAlerts = false;
  bool _enableWaterAlerts = false;
  String _languageSelection = SettingsUtil.languages.first;
  String _unitsSelection = SettingsUtil.units.first;
  String _fontSizeSelection = SettingsUtil.fontsize[1];
  String? _locationSelection = SharedPrefUtil.getLocation();
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (SharedPrefUtil.getIsLoggedIn() == true) {
      setSettings();
    } else {
      SharedPrefUtil.setLanguage(_languageSelection);
      SharedPrefUtil.setFontSize(_fontSizeSelection);
      SharedPrefUtil.setConserveEnergy(_enableEnergyAlerts
          .toString()); // need to update shared pref to boolean or use string val in onChnaged function
      SharedPrefUtil.setConserveWater(_enableWaterAlerts
          .toString()); // need to update shared pref to boolean or use string val in onChnaged function
      SharedPrefUtil.setApiRelated(_enableApiAlerts
          .toString()); // need to update shared pref to boolean or use string val in onChnaged function
      SharedPrefUtil.setTempFormat(_unitsSelection);
      SharedPrefUtil.setTheme(_enableDarkTheme
          .toString()); // need to update shared pref to boolean or use string val in onChnaged function
      //SharedPrefUtil.checkAllPrefs(); // commented out to avoid printing in all branches
    }
  }

  // this should be done at login... if a user has logged in, shared prefs will be preserved
  // ... talk to Doug about why this might be redundant
  void setSettings() async {
    var uId = SharedPrefUtil.getUserPrefId();
    var pref = await SQLHelper.getUserPref(uId);
    var lang = pref[0]['lang'];
    var font = pref[0]['fontSize'];
    var theme = pref[0]['theme'];
    var tFormat = pref[0]['tempFormat'];
    var location = pref[0]['location'];
    SharedPrefUtil.setLanguage(lang);
    SharedPrefUtil.setLocation(location);
    SharedPrefUtil.setFontSize(font);
    SharedPrefUtil.setTheme(theme);
    SharedPrefUtil.setTempFormat(tFormat);
    SharedPrefUtil.setLocation(location);

    // TODO: Below code will need to be debugged

    // if (SharedPrefUtil.getLanguage() == 'spanish') {
    //   _languageSet = LanguageSet.spanish;
    // }

    // if (SharedPrefUtil.getFontSize() == "medium") {
    //   _fontSet = FontSet.medium;
    // } else if (SharedPrefUtil.getFontSize() == "large") {
    //   _fontSet = FontSet.large;
    // }

    // if (SharedPrefUtil.getTheme() == "dark") {
    //   _themeSet = ThemeSet.dark;
    // }

    // if (SharedPrefUtil.getTempFormat() == "celsius") {
    //   _tempSet = TempSet.celsius;
    // }
  }

  void setCoordinates(String loc) async {
    if (SharedPrefUtil.getIsLoggedIn()) {
      await SQLHelper.updateLocation(SharedPrefUtil.getUserPrefId(), loc);
    }
    var geoLocation = await WeatherHelper.getGeoCoords();
    var lat = geoLocation?[0]['lat'];
    var lon = geoLocation?[0]['lon'];
    SharedPrefUtil.setLatitude(lat);
    SharedPrefUtil.setLongitude(lon);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text(widget.title)),
      child: SafeArea(
        bottom: false,
        child: SettingsList(
          applicationType: ApplicationType.cupertino,
          platform: DevicePlatform.iOS,
          sections: [
            SettingsSection(
              title: const Text('PREFERENCES'),
              tiles: [
                SettingsTile.navigation(
                  onPressed:
                      (_) {}, // intentionally blank, use DropdownButton2 onChanged =>setstate
                  title: const Text('Language'),
                  value: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      iconStyleData: const IconStyleData(
                        icon: Visibility(
                            visible: false,
                            child: Icon(Icons.arrow_forward_ios_outlined)),
                      ),
                      dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: 200,
                          isOverButton: true,
                          padding: null,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.grey.shade50),
                          elevation: 8,
                          offset: const Offset(10, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          )),
                      items: SettingsUtil.languages
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: SizedBox(
                                  width: 200,
                                  child: Text(
                                    item,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                      value: _languageSelection,
                      onChanged: (value) {
                        setState(() {
                          _languageSelection = value as String;
                          // push _[*]selection to sharedpref and update database with shared pref val
                          // update locale settings for languages, (https://stackoverflow.com/questions/65307961/button-to-change-the-language-flutter)
                        });
                      },
                      buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 5)),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                ),
                SettingsTile.navigation(
                  onPressed:
                      (_) {}, // intentionally blank, use DropdownButton2 onChanged =>setstate
                  title: const Text('Font Size'),
                  value: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      iconStyleData: const IconStyleData(
                        icon: Visibility(
                            visible: false,
                            child: Icon(Icons.arrow_forward_ios_outlined)),
                      ),
                      dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: 200,
                          isOverButton: true,
                          padding: null,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.grey.shade50),
                          elevation: 8,
                          offset: const Offset(10, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          )),
                      items: SettingsUtil.fontsize
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: SizedBox(
                                  width: 200,
                                  child: Text(
                                    item,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                      value: _fontSizeSelection,
                      onChanged: (value) {
                        setState(() {
                          _fontSizeSelection = value as String;
                          // push _[*]selection to sharedpref and update database with shared pref val
                          // will need to scale font size by a factor (this may be a stretch goal)
                        });
                      },
                      buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 5)),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SettingsSection(
              title: const Text('WEATHER'),
              tiles: [
                SettingsTile.navigation(
                  onPressed:
                      (_) {}, // intentionally blank, use DropdownButton2 onChanged =>setstate
                  title: const Text('Units'),
                  value: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      iconStyleData: const IconStyleData(
                        icon: Visibility(
                            visible: false,
                            child: Icon(Icons.arrow_forward_ios_outlined)),
                      ),
                      dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: 200,
                          isOverButton: true,
                          padding: null,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.grey.shade50),
                          elevation: 8,
                          offset: const Offset(10, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          )),
                      items: SettingsUtil.units
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: SizedBox(
                                  width: 200,
                                  child: Text(
                                    item,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                      value: _unitsSelection,
                      onChanged: (value) {
                        setState(() {
                          _unitsSelection = value as String;
                          // push _[*]selection to sharedpref and update database with shared pref val
                          // call to OpenAPI will need to be updated with new units
                          // ...display units on Home, Analysis, and potentially radar pg will need to be updated
                          // ...do we want to update old values in database with updated units??
                          // this will likely be a team check-in question
                        });
                      },
                      buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 5)),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                ),
                SettingsTile.navigation(
                  title: const Text('Location'),
                  value: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      iconStyleData: const IconStyleData(
                        icon: Visibility(
                            visible: false,
                            child: Icon(Icons.arrow_forward_ios_outlined)),
                      ),
                      isExpanded: true,
                      hint: SizedBox(
                        width: 200,
                        child: Text(
                          'Select Item',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ),
                      items: SettingsUtil.citySelection
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: SizedBox(
                                  width: 200,
                                  child: Text(
                                    item,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                      value: _locationSelection,
                      onChanged: (value) {
                        setState(() {
                          _locationSelection = value as String;
                          SharedPrefUtil.setLocation(
                              _locationSelection as String);
                          setCoordinates(value);
                          // push _[*]selection to sharedpref and update database with shared pref val
                          // api call to Openweather geolocation API will need to be made here
                          // talk to Jordan about where this information needs to be stored permanently
                          //  to ensure that analysis and radar page work without error
                        });
                      },
                      buttonStyleData: const ButtonStyleData(
                        height: 40,
                        width: 200,
                        padding: EdgeInsets.only(right: 5),
                      ),
                      dropdownStyleData: const DropdownStyleData(
                        maxHeight: 200,
                        width: 200,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                      dropdownSearchData: DropdownSearchData(
                        searchController: textEditingController,
                        searchInnerWidgetHeight: 50,
                        searchInnerWidget: Container(
                          height: 50,
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 4,
                            right: 8,
                            left: 8,
                          ),
                          child: TextFormField(
                            expands: true,
                            maxLines: null,
                            controller: textEditingController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              hintText: 'Search for an item...',
                              hintStyle: const TextStyle(fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        searchMatchFn: (item, searchValue) {
                          return (item.value
                              .toString()
                              .toLowerCase()
                              .contains(searchValue.toLowerCase()));
                        },
                      ),
                      //This to clear the search value when you close the menu
                      onMenuStateChange: (isOpen) {
                        if (!isOpen) {
                          textEditingController.clear();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            SettingsSection(
              title: const Text('NOTIFICATIONS'),
              tiles: [
                SettingsTile.switchTile(
                  title: const Text('API Related Alerts'),
                  initialValue: _enableApiAlerts,
                  activeSwitchColor: const Color.fromARGB(255, 0, 83, 129),
                  onToggle: (value) {
                    setState(() {
                      _enableApiAlerts = value;
                      // push to sharedpref and update database
                    });
                  },
                ),
                SettingsTile.switchTile(
                  title: const Text('Energy Alerts'),
                  initialValue: _enableEnergyAlerts,
                  activeSwitchColor: const Color.fromARGB(255, 0, 83, 129),
                  onToggle: (value) {
                    setState(() {
                      _enableEnergyAlerts = value;
                      // push to sharedpref and update database
                    });
                  },
                ),
                SettingsTile.switchTile(
                  title: const Text('Water Alerts'),
                  initialValue: _enableWaterAlerts,
                  activeSwitchColor: const Color.fromARGB(255, 0, 83, 129),
                  onToggle: (value) {
                    setState(() {
                      _enableWaterAlerts = value;
                      // push to sharedpref and update database
                    });
                  },
                ),
              ],
            ),
            SettingsSection(
              title: const Text('DISPLAY'),
              tiles: [
                SettingsTile.switchTile(
                  title: const Text('Enable Dark Theme'),
                  initialValue: _enableDarkTheme,
                  activeSwitchColor: const Color.fromARGB(255, 0, 83, 129),
                  onToggle: (value) {
                    setState(() {
                      _enableDarkTheme = value;
                      // push to sharedpref and update database
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
