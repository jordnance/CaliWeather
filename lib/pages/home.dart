import '../util/weather_helper.dart';
import 'package:weather/weather.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../util/home_utest_util.dart';
import 'components/mainweather.dart';
import 'components/forecast.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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

class MicroWeather extends StatelessWidget {
  late String description;
  late String areaName;
  late String cloudiness;
  late String country;
  late String date;
  late String humidity;
  late String latitude;
  late String longitude;
  late String pressure;
  late String rainLast3Hours;
  late String rainLastHour;
  late String snowLast3Hours;
  late String snowLastHour;
  late String sunrise;
  late String sunset;
  late String tempFeelsLike;
  late String tempMax;
  late String tempMin;
  late String temperature;
  late String weatherConditionCode;
  late String weatherDescription;
  late String weatherIcon;
  late String weatherMain;
  late String windDegree;
  late String windGust;
  late String windSpeed;

  MicroWeather({super.key});

  //MicroWeather(this.description, {super.key});

  void init() async {
    Weather weather = await WeatherHelper.getCurrent();
    areaName = weather.areaName.toString();
    cloudiness = weather.cloudiness.toString();
    country = weather.country.toString();
    date = weather.date.toString();
    //hashCode = weather.hashCode.toString();
    humidity = weather.humidity.toString();
    latitude = weather.latitude.toString();
    longitude = weather.longitude.toString();
    pressure = weather.pressure.toString();
    rainLast3Hours = weather.rainLast3Hours.toString();
    rainLastHour = weather.rainLastHour.toString();
    //runtimeType = weather.runtimeType.toString();
    snowLast3Hours = weather.snowLast3Hours.toString();
    snowLastHour = weather.snowLastHour.toString();
    sunrise = weather.sunrise.toString();
    sunset = weather.sunset.toString();
    tempFeelsLike = weather.tempFeelsLike.toString();
    tempMax = weather.tempMax.toString();
    tempMin = weather.tempMin.toString();
    temperature = weather.temperature.toString();
    weatherConditionCode = weather.weatherConditionCode.toString();
    weatherDescription = weather.weatherDescription.toString();
    weatherIcon = weather.weatherIcon.toString();
    weatherMain = weather.weatherMain.toString();
    windDegree = weather.windDegree.toString();
    windGust = weather.windGust.toString();
    windSpeed = weather.windSpeed.toString();
  }

  @override
  Widget build(BuildContext context) {
    init();

    /// ************* temporary data until API calls are brought in ********************** ///
    ///
    String units = "°F"; //NOTE: may need to pull from settings

    ///
    /// ***============================================================================*** ///

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            'Max: $tempMax',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              //color: Color.fromARGB(255, 87, 87, 87),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            'Cloudiness: $cloudiness',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              //color: Color.fromARGB(255, 87, 87, 87),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            'Humidity: $humidity',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              //color: Color.fromARGB(255, 87, 87, 87),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            'Pressure: $pressure',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              //color: Color.fromARGB(255, 87, 87, 87),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            'Feels like: $tempFeelsLike',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              //color: Color.fromARGB(255, 87, 87, 87),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            'Sunrise: $sunrise',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              //color: Color.fromARGB(255, 87, 87, 87),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            'Sunset: $sunset',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              //color: Color.fromARGB(255, 87, 87, 87),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            'Main: $weatherMain',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              //color: Color.fromARGB(255, 87, 87, 87),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            'Description: $weatherDescription',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              //color: Color.fromARGB(255, 87, 87, 87),
            ),
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

    final PageController pgController = PageController();

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: PageView(
                controller: pgController,
                children: <Widget>[
                  MainWeather(temp, desc, city, opwKey),
                  MicroWeather(),
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
              color: const Color.fromARGB(255, 87, 87, 87).withOpacity(0.6),
              onPressed: () {
                setState(() {}); //NOTE: Temporary functionality
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
            ),
          ),
        ],
      ),
    );
  }
}
