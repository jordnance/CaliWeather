import 'sql_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///* temporary; generating weather and date values *///
import 'dart:math';

final rnd = Random(DateTime.now().millisecondsSinceEpoch);
int getRndVal() => 15 + rnd.nextInt(95); //min temp: 15,  max temp: 110
final String currDay = DateFormat('MMM dd').format(DateTime.now()).toString();
String nextDay(int offset) => DateFormat('MMM dd')
    .format(DateTime.now().add(Duration(days: offset)))
    .toString();

///*************************************************///

class ForecastWeather extends StatelessWidget {
  final int temperature;
  final String description;
  final String date;
  final Icon weathIcon =
      const Icon(Icons.cloudy_snowing, size: 50, color: Colors.white);

  const ForecastWeather(this.temperature, this.description, this.date,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white.withOpacity(0.5),
      child: SizedBox(
        width: 160.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: weathIcon,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                temperature.toString(),
                style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                description,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              ),
            ),
            Text(
              date,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
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
  final Icon weathIcon =
      const Icon(Icons.cloudy_snowing, size: 150, color: Colors.white);

  const MainWeather(this.temperature, this.description, this.city, this.date,
      {super.key});

  int get getTemp {
    return temperature.toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: weathIcon,
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            temperature.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 140,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
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
  List<Color> bgColorList = [
    Colors.blueGrey,
    Colors.amberAccent,
    Colors.purpleAccent
  ];

  //int test = MainWeather.getTemp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: bgColorList[0], // dynamic change needed
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MainWeather(getRndVal(), "Cloudy", "Bakersfield", currDay),
                  IconButton(
                    iconSize: 25,
                    icon: const Icon(Icons.refresh),
                    color: Colors.white.withOpacity(0.6),
                    onPressed: () {
                      // ...
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                //color: Colors.deepPurple, // debugging row height
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          ForecastWeather(getRndVal(), "Cloudy", nextDay(1)),
                          ForecastWeather(getRndVal(), "Cloudy", nextDay(2)),
                          ForecastWeather(getRndVal(), "Cloudy", nextDay(3)),
                          ForecastWeather(getRndVal(), "Cloudy", nextDay(4)),
                          ForecastWeather(getRndVal(), "Cloudy", nextDay(5)),
                          ForecastWeather(getRndVal(), "Cloudy", nextDay(6)),
                          ForecastWeather(getRndVal(), "Cloudy", nextDay(7)),
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
