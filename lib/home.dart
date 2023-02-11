import 'sql_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';
import 'util/weather_icon_util.dart';
import 'util/home_utest_util.dart';

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
      color: Colors.white.withOpacity(0.30),
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

class MainWeather extends StatelessWidget {
  final int temperature;
  final String description;
  final String city;
  final String date;
  final int opwKey;

  const MainWeather(
      this.temperature, this.description, this.city, this.date, this.opwKey,
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
            size: 120, color: Colors.white),
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
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Text(
                units,
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            description,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            city,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            DateFormat('MMM dd').format(DateTime.now()).toString(),
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    /// ************* temporary data until API calls are brought in ********************** ///
    ///

    //temporary get main temperature value
    int temp = getRndVal();
    //function for forecast temps near main 'temp'
    int ftemp() => (temp - 10) + rnd.nextInt(10);

    //generate random ID from possible OpenWeatherAPI ID's
    var opwKey = HomeTestUtil
        .utest_idList[rnd.nextInt(HomeTestUtil.utest_idList.length)];
    // String key = iconCode[4];
    // String iconStr = WeatherIconsUtil.iconMap[key].toString();
    String desc = HomeTestUtil.utest_descMap[opwKey].toString();
    String city = "Bakersfield";

    ///
    /// ***============================================================================*** ///

    late Color bgColor;
    List<Color> bgColorList = [
      Colors.indigo,
      Colors.blueGrey,
      const Color.fromARGB(255, 254, 169, 0)
    ];

    if (temp >= 70) {
      bgColor = bgColorList[2];
    } else if (temp >= 30 && temp < 70) {
      bgColor = bgColorList[1];
    } else {
      bgColor = bgColorList[0];
    }

    return Scaffold(
      body: Container(
        color: bgColor,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MainWeather(temp, desc, city, currDay, opwKey),
                  IconButton(
                    iconSize: 25,
                    icon: const Icon(Icons.refresh),
                    color: Colors.white.withOpacity(0.6),
                    onPressed: () {
                      setState(() {}); //NOTE: Temporary functionality
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          ForecastWeather(ftemp(), desc, nextDay(1), opwKey),
                          ForecastWeather(ftemp(), desc, nextDay(2), opwKey),
                          ForecastWeather(ftemp(), desc, nextDay(3), opwKey),
                          ForecastWeather(ftemp(), desc, nextDay(4), opwKey),
                          ForecastWeather(ftemp(), desc, nextDay(5), opwKey),
                          ForecastWeather(ftemp(), desc, nextDay(6), opwKey),
                          ForecastWeather(ftemp(), desc, nextDay(7), opwKey),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
