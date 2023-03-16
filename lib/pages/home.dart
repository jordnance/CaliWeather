import 'package:caliweather/util/weather_helper.dart';
import 'package:flutter/material.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:caliweather/pages/components/microweather.dart';
import 'package:caliweather/pages/components/mainweather.dart';
import 'package:caliweather/pages/components/forecast.dart';
import 'package:caliweather/pages/components/ambientweather.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:environment_sensors/environment_sensors.dart';

@pragma('vm:entry-point')
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  bool isTimeout = task.timeout;
  if (isTimeout) {
    BackgroundFetch.finish(taskId);
    return;
  }
  BackgroundFetch.finish(taskId);
}

class Todo {
  final String mainData;
  final String microData;
  final String forecastData;
  final String ambientTemp;
  final String ambientHum;
  final String ambientLight;
  final String ambientPress;

  const Todo(this.mainData, this.microData, this.forecastData, this.ambientTemp,
      this.ambientHum, this.ambientLight, this.ambientPress);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double currentPage = 0;
  List<dynamic>? micro;
  List<dynamic>? forecast;
  List<dynamic>? main;
  bool _tempAvailable = false;
  bool _humidityAvailable = false;
  bool _lightAvailable = false;
  bool _pressureAvailable = false;
  Color bgColor = Colors.grey.shade200;
  final environmentSensors = EnvironmentSensors();
  final PageController pgController = PageController();

  @override
  void initState() {
    super.initState();
    initSensorState();
    initBackgroundState();
    startBackgroundService();
  }

  Future<void> initSensorState() async {
    bool tempAvailable;
    bool humidityAvailable;
    bool lightAvailable;
    bool pressureAvailable;

    tempAvailable = await environmentSensors
        .getSensorAvailable(SensorType.AmbientTemperature);
    humidityAvailable =
        await environmentSensors.getSensorAvailable(SensorType.Humidity);
    lightAvailable =
        await environmentSensors.getSensorAvailable(SensorType.Light);
    pressureAvailable =
        await environmentSensors.getSensorAvailable(SensorType.Pressure);

    setState(() {
      _tempAvailable = tempAvailable;
      _humidityAvailable = humidityAvailable;
      _lightAvailable = lightAvailable;
      _pressureAvailable = pressureAvailable;
    });
  }

  Future<void> initBackgroundState() async {
    await BackgroundFetch.configure(
        BackgroundFetchConfig(
            minimumFetchInterval: 360,
            startOnBoot: true,
            stopOnTerminate: false,
            enableHeadless: true,
            requiresBatteryNotLow: false,
            requiresStorageNotLow: false,
            requiresDeviceIdle: false,
            requiredNetworkType: NetworkType.NONE), (String taskId) async {
      setState(() {});
      BackgroundFetch.finish(taskId);
    });
    if (!mounted) return;
  }

  void startBackgroundService() {
    BackgroundFetch.start();
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
    return Scaffold(
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
                return Column(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: PageView(
                          controller: pgController,
                          children: <Widget>[
                            MainWeather(todos: main),
                            MicroWeather(todos: micro),
                            AmbientWeather(
                                ambientTemp: _tempAvailable,
                                ambientHum: _humidityAvailable,
                                ambientLight: _lightAvailable,
                                ambientPress: _pressureAvailable)
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: pgController,
                        count: 3,
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
                          setState(() {});
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
                );
            }
          }),
    );
  }
}
