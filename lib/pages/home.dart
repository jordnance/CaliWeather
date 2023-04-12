import 'dart:async';
import 'package:intl/intl.dart';
import 'package:caliweather/util/weather_helper.dart';
import 'package:flutter/material.dart';
import 'package:caliweather/pages/components/microweather.dart';
import 'package:caliweather/pages/components/mainweather.dart';
import 'package:caliweather/pages/components/forecast.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flash/flash.dart';

class Todo {
  final String mainData;
  final String microData;
  final String forecastData;

  const Todo(this.mainData, this.microData, this.forecastData);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? apiCallTimer;
  List<dynamic>? micro;
  List<dynamic>? forecast;
  List<dynamic>? main;
  List<dynamic>? alerts;
  bool checkLimit = false;
  bool showAlertIndicator = false;

  Color bgColor = Colors.grey.shade200;
  final PageController pgController = PageController();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    apiCallTimer?.cancel();
    super.dispose();
  }

  void startTimer() {
    apiCallTimer = Timer.periodic(const Duration(minutes: 5), (Timer t) async {
      checkLimit = true;
    });
  }

  Future<void> getData() async {
    Map<String, dynamic>? weatherData = await WeatherHelper.getCurrent();

    if (weatherData != null) {
      micro = await WeatherHelper.getMicroweather(weatherData);
      forecast = await WeatherHelper.getForecast(weatherData);
      main = await WeatherHelper.getMainweather(weatherData);
      alerts = weatherData['alerts'];

      if (alerts != null) {
        showAlertIndicator = true;
      } else {
        showAlertIndicator = false;
      }
    }
  }

  void showMessage(String message,
      {FlashBehavior style = FlashBehavior.floating}) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 3),
      persistent: true,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          boxShadows: const [BoxShadow(blurRadius: 4)],
          barrierDismissible: true,
          behavior: style,
          position: FlashPosition.top,
          child: FlashBar(
            content: Text(message),
            showProgressIndicator: true,
            primaryAction: TextButton(
              onPressed: () => controller.dismiss(),
              child:
                  const Text('DISMISS', style: TextStyle(color: Colors.amber)),
            ),
          ),
        );
      },
    );
  }

  void _showAlerts() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Active Alerts',
              textAlign: TextAlign.center,
            ),
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            scrollable: true,
            content: setupAlertDialoadContainer(),
          );
        });
  }

  Widget setupAlertDialoadContainer() {
    return SizedBox(
      height: 300.0,
      width: 400.0,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: alerts!.length.toInt(),
        itemBuilder: (BuildContext context, int index) {
          return ExpansionTile(
            backgroundColor: const Color.fromARGB(10, 68, 137, 255),
            title: Text(alerts![index]['event'].toString()),
            subtitle: Text(
                'Until ${DateFormat('MMM dd').format(DateTime.fromMillisecondsSinceEpoch((alerts![index]['end'].toInt()) * 1000))}'),
            children: <Widget>[
              Text(alerts![index]['description'].toString()),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<void>(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Center(
                    child: Text("None"),
                  );
                case ConnectionState.waiting:
                  return const Center(
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator()),
                  );
                case ConnectionState.active:
                  return const Center(child: Text("Active"));
                case ConnectionState.done:
                  return Stack(
                    children: [
                      Column(
                        children: <Widget>[
                          Expanded(
                            child: Center(
                              child: PageView(
                                controller: pgController,
                                children: <Widget>[
                                  MainWeather(todos: main),
                                  MicroWeather(todos: micro),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: SmoothPageIndicator(
                              controller: pgController,
                              count: 2,
                              axisDirection: Axis.horizontal,
                              effect: SlideEffect(
                                activeDotColor: Colors.blueGrey,
                                dotHeight: 10,
                                dotColor: Colors.grey.shade400,
                                dotWidth: 10,
                              ),
                            ),
                          ),
                          Center(
                            child: IconButton(
                              iconSize: 25,
                              icon: const Icon(Icons.refresh),
                              color: const Color.fromARGB(255, 87, 87, 87)
                                  .withOpacity(0.6),
                              onPressed: () {
                                if (checkLimit) {
                                  checkLimit = false;
                                  setState(() {});
                                } else {
                                  showMessage(
                                      'Last refresh was less than 5 minutes ago');
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.30,
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: <Widget>[
                                          ForecastWeather(todos: forecast?[0]),
                                          ForecastWeather(todos: forecast?[1]),
                                          ForecastWeather(todos: forecast?[2]),
                                          ForecastWeather(todos: forecast?[3]),
                                          ForecastWeather(todos: forecast?[4]),
                                          ForecastWeather(todos: forecast?[5]),
                                          ForecastWeather(todos: forecast?[6]),
                                          ForecastWeather(todos: forecast?[7])
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: showAlertIndicator,
                        child: Positioned(
                          child: Container(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: const ImageIcon(
                                  AssetImage('assets/logo_alert_nobg.png')),
                              color: const Color.fromARGB(255, 0, 83, 129),
                              iconSize: 55,
                              onPressed: () {
                                _showAlerts();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
              }
            }),
      ),
    );
  }
}
