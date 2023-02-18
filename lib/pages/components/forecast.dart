import 'package:flutter/material.dart';
import '../../util/weather_icon_util.dart';
import '../../util/home_utest_util.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:caliweather/weather_helper.dart';
import 'package:intl/intl.dart';

///********************** temporary; generating weather and date values ****************************///
import 'dart:math';

// seed random
final rnd = Random(DateTime.now().millisecondsSinceEpoch);

//random temp
int getRndVal() => 15 + rnd.nextInt(95); //min temp: 15,  max temp: 110

//temporary date values
final String currDay = DateFormat('MMM dd').format(DateTime.now()).toString();
String nextDay(int offset) => DateFormat('MMM dd')
    .format(DateTime.now().add(Duration(days: offset)))
    .toString();

//generate random ID from possible OpenWeatherAPI ID's
var testID =
    HomeTestUtil.utest_idList[rnd.nextInt(HomeTestUtil.utest_idList.length)];

///*************************************************************************************************///
///
class ForecastWeather extends StatelessWidget {
  final int temperature;
  final String description;
  final String date;
  final int opwKey;

  const ForecastWeather(
      this.temperature, this.description, this.date, this.opwKey,
      {super.key});

  @override
  Widget build(BuildContext context) {
    /// ************* temporary data until API calls are brought in ********************** ///
    ///
    var opwKey = HomeTestUtil
        .utest_idList[rnd.nextInt(HomeTestUtil.utest_idList.length)];
    String desc = HomeTestUtil.utest_descMap[opwKey].toString();
    String units = "°F"; //NOTE: may need to pull from settings
    String iconKey = HomeTestUtil.utest_opwIconMap[opwKey].toString();
    String iconName = WeatherIconsUtil.iconMap[iconKey].toString();

    ///
    /// ***============================================================================*** ///

    return Card(
      elevation: 0,
      color: const Color.fromARGB(255, 87, 87, 87).withOpacity(0.30),
      child: SizedBox(
        width: 160.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: BoxedIcon(WeatherIcons.fromString(iconName),
                  size: 30, color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    temperature.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    units,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                desc, //TODO: change back to 'description' with API call
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
            Text(
              date,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
