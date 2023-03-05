import 'package:caliweather/util/weather_helper.dart';
import 'package:flutter/material.dart';
import 'package:caliweather/pages/components/microweather.dart';
import 'package:caliweather/pages/components/mainweather.dart';
import 'package:caliweather/pages/components/forecast.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
  double currentPage = 0;
  final PageController pgController = PageController();
  List<dynamic>? micro;
  List<dynamic>? forecast;
  List<dynamic>? main;
  Color bgColor = Colors.grey.shade200;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    List microData = await WeatherHelper.getMicroweather();
    List forecastData = await WeatherHelper.getForecast();
    List mainData = await WeatherHelper.getMainweather();
    micro = microData;
    forecast = forecastData;
    main = mainData;
  }

  @override
  Widget build(BuildContext context) {
    final PageController pgController = PageController();

    return Scaffold(
      body: FutureBuilder<void>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(
                  child: Text("None"), // <-- TESTING
                );
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
                return const Center(child: Text("Active")); // <-- TESTING
              case ConnectionState.done:
                return Stack(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      padding:
                          EdgeInsets.only(top: 55.0, right: 15.0, left: 15.0),
                      child: Image.asset(
                        'assets/logo_alert_nobg.png',
                        height: 55,
                      ),
                    ),
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
                              getData(); // <-- TESTING
                              setState(() {}); // <-- TESTING
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
                  ],
                );
            }
          }),
    );
  }
}
