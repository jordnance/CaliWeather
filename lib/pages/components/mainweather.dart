import 'package:flutter/material.dart';
import '../../util/weather_icon_util.dart';
import 'package:weather_icons/weather_icons.dart';

class MainWeather extends StatelessWidget {
  const MainWeather({super.key, required this.todos});
  final List<dynamic>? todos;
  
  @override
  Widget build(BuildContext context) {
    String iconName = WeatherIconsUtil.iconMap[todos?[0]].toString();
    String units = "°F"; // TODO: Pull from settings/database

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        BoxedIcon(WeatherIcons.fromString(iconName),
            size: 110, color: const Color.fromARGB(255, 87, 87, 87)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                '${todos?[1]}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 115,
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
            '${todos?[2]}',
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 87, 87, 87)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            '${todos?[3]}',
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
            '${todos?[4]}',
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
