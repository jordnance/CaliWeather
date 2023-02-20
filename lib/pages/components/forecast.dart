import 'package:flutter/material.dart';
import '../../util/weather_icon_util.dart';
import 'package:weather_icons/weather_icons.dart';

class ForecastWeather extends StatelessWidget {
  final List<dynamic>? todos;

  const ForecastWeather({
    super.key,
    required this.todos,
  });

  @override
  Widget build(BuildContext context) {
    String iconName = WeatherIconsUtil.iconMap[todos?[3]].toString();
    String units = "°F"; // TODO: Pull from settings/database

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
                    '${todos![0]}'.toString(),
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
                '${todos![1]}',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
            Text(
              '${todos![2]}',
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
