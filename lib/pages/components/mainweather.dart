import 'package:flutter/material.dart';
import '../../util/weather_icon_util.dart';
import '../../util/home_utest_util.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:caliweather/weather_helper.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';

class MainWeather extends StatelessWidget {
  final int temperature;
  final String description;
  final String city;
  final int opwKey;

  const MainWeather(this.temperature, this.description, this.city, this.opwKey,
      {super.key});

  @override
  Widget build(BuildContext context) {
    /// ************* temporary data until API calls are brought in ********************** ///
    ///
    String units = "°F"; //NOTE: may need to pull from settings
    String iconKey = HomeTestUtil.utest_opwIconMap[opwKey].toString();
    String iconName = WeatherIconsUtil.iconMap[iconKey].toString();

    ///
    /// ***============================================================================*** ///

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        BoxedIcon(WeatherIcons.fromString(iconName),
            size: 120, color: const Color.fromARGB(255, 87, 87, 87)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                temperature.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 110,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 87, 87, 87)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Text(
                units,
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 87, 87, 87)),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            description,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 87, 87, 87)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            city,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: Color.fromARGB(255, 87, 87, 87)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            DateFormat('MMM dd').format(DateTime.now()).toString(),
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Color.fromARGB(255, 87, 87, 87)),
          ),
        ),
      ],
    );
  }
}
