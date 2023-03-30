import 'package:caliweather/util/sql_helper.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'globals.dart' as globals;
import '../util/sharedprefutil.dart';

class WeatherHelper {
  static Future<List<dynamic>> getGeo() async {
    http.Response geoResponse = await http.get(
      Uri.https('api.openweathermap.org', '/geo/1.0/reverse', {
        'lat': globals.positionLat.toString(),
        'lon': globals.positionLong.toString(),
        'appid': '0d8187b327e042982d4478dcbf90bae3',
      }),
    );

    List<dynamic> g = jsonDecode(geoResponse.body);
    return g;
  }

  static Future<Map<String, dynamic>> getCurrent() async {
    var g = await getGeo();

    http.Response weatherResponse = await http.get(
      Uri.https('api.openweathermap.org', '/data/3.0/onecall', {
        'lat': globals.positionLat.toString(),
        'lon': globals.positionLong.toString(),
        'exclude': 'hourly,minutely',
        'appid': '0d8187b327e042982d4478dcbf90bae3',
        'units': 'imperial',
        'lang': 'en',
      }),
    );

    Map<String, dynamic> w = jsonDecode(weatherResponse.body);

    if (SharedPrefUtil.getIsLoggedIn()) {
      SQLHelper.updateLocation(SharedPrefUtil.getUserPrefId(), g[0]['name']);
      SharedPrefUtil.setLocation(g[0]['name']);
    }

    return w;
  }

  static Future<List<dynamic>> setForecast() async {
    List<dynamic> setData = [];
    List<dynamic> forecast = [];

    var weather = await getCurrent();

    for (int i = 0; i < 8; i++) {
      forecast.insert(i, weather['daily'][i]);
      setData.insert(i, forecast[i]);
    }

    return setData;
  }

  static Future<List> getForecast() async {
    List<dynamic> formatData = [[], [], [], [], [], [], [], []];
    List<dynamic> forecastData = await setForecast();

    for (int i = 0; i < 8; i++) {
      DateTime? formatDate =
          DateTime.fromMillisecondsSinceEpoch(forecastData[i]['dt'] * 1000);

      String? temp = forecastData[i]['temp']['day'].toStringAsFixed(0)!;
      String desc = forecastData[i]['weather'][0]['main'].toString();
      String icon = forecastData[i]['weather'][0]['icon'].toString();
      String date = DateFormat('MMM dd').format(formatDate);

      formatData[i] = [temp, desc, date, icon];
    }
    return formatData;
  }

  static Future<List?> getAlerts() async {
    http.Response response = await http.get(
      Uri.https('api.openweathermap.org', '/data/3.0/onecall', {
        'lat': globals.positionLat.toString(),
        'lon': globals.positionLong.toString(),
        'exclude': 'daily,hourly,minutely',
        'appid': '0d8187b327e042982d4478dcbf90bae3'
      }),
    );

    if (response.statusCode != 200) {
      //print(response.statusCode);
      return null;
    }

    Map<String, dynamic> w = jsonDecode(response.body);
    return w['alerts'];
  }

  static Future<List> getMainweather() async {
    var weather = await getCurrent();
    var geo = await getGeo();

    DateTime formatDate =
        DateTime.fromMillisecondsSinceEpoch(weather['current']['dt'] * 1000);
    String date = DateFormat('MMM dd').format(formatDate);

    String weatherIcon = weather['current']['weather'][0]['icon'];
    String temperature = weather['current']['temp'].toStringAsFixed(0);
    String weatherMain = weather['current']['weather'][0]['main'];
    String areaName = geo[0]['name'];

    date = DateFormat('MMM dd').format(formatDate);

    List<String?> mainData = [
      weatherIcon,
      temperature,
      weatherMain,
      areaName,
      date
    ];

    return mainData;
  }

  static Future<List> getMicroweather() async {
    var weather = await getCurrent();
    var geo = await getGeo();

    DateTime formatSunrise = DateTime.fromMillisecondsSinceEpoch(
        weather['current']['sunrise'] * 1000);

    DateTime formatSunset = DateTime.fromMillisecondsSinceEpoch(
        weather['current']['sunset'] * 1000);

    String sunrise = DateFormat.jm().format(formatSunrise);
    String sunset = DateFormat.jm().format(formatSunset);

    String areaName = geo[0]['name'];
    String cloudiness = "${weather['current']['clouds']}%";
    String dewPoint =
        "${weather['current']['dew_point'].toStringAsFixed(0)} °F";
    String humidity = "${weather['current']['humidity']}%";

    String pressure =
        "${weather['current']['pressure'].toStringAsFixed(0)} hPa";

    String? rainLastHour;
    if (weather['current']['rain'] != null) {
      rainLastHour = "${weather['current']['rain']['1h']} mm";
    } else {
      rainLastHour = '0';
    }

    String? snowLastHour;
    if (weather['current']['snow'] != null) {
      rainLastHour = "${weather['current']['snow']['1h']} mm";
    } else {
      snowLastHour = '0';
    }

    String tempFeelsLike =
        "${weather['current']['feels_like'].toStringAsFixed(0)} °F";

    String? temperature =
        "${(weather['current']['temp'].toStringAsFixed(1))!} °F";

    String uvi = "${weather['current']['uvi'].toStringAsFixed(0)} of 10";
    String weatherDescription =
        weather['current']['weather'][0]['description'].toString();
    weatherDescription = weatherDescription.replaceFirst(
        weatherDescription[0], weatherDescription[0].toUpperCase());

    String windSpeed =
        "${weather['current']['wind_speed'].toStringAsFixed(0)} mph";

    List<String?> microData = [
      cloudiness,
      dewPoint,
      humidity,
      pressure,
      sunrise,
      sunset,
      tempFeelsLike,
      weatherDescription,
      uvi,
      windSpeed
    ];

    if (SharedPrefUtil.getIsLoggedIn()) {
      int? userId = SharedPrefUtil.getUserId();
      var getFreq = await SQLHelper.getFrequency(userId);
      var frequency = getFreq[0]['COUNT(*)'];
      if (frequency == 0) {
        String formatTemp = temperature.replaceAll('°F', '');
        double doubleTemp = double.parse(formatTemp);
        double newTemp = double.parse(doubleTemp.toStringAsFixed(1));

        DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
        String apiCallDate = dateFormat.format(DateTime.now());

        String formatRain = rainLastHour.replaceAll('mm', '');
        double doubleRain = double.parse(formatRain);
        double newRain = double.parse(doubleRain.toStringAsFixed(1));

        String formatHum = humidity.replaceAll('%', '');
        double doubleHum = double.parse(formatHum);
        double newHum = double.parse(doubleHum.toStringAsFixed(1));

        String formatSnow = snowLastHour!.replaceAll('mm', '');
        double doubleSnow = double.parse(formatSnow);
        double newSnow = double.parse(doubleSnow.toStringAsFixed(1));

        String formatPress = pressure.replaceAll('hPa', '');
        double doublePress = double.parse(formatPress);
        double newPress = double.parse(doublePress.toStringAsFixed(1));

        String formatWind = windSpeed.replaceAll('mph', '');
        double doubleWind = double.parse(formatWind);
        double newWind = double.parse(doubleWind.toStringAsFixed(1));

        SQLHelper.createWeatherData(userId, apiCallDate, areaName, newRain,
            newTemp, newHum, newSnow, newPress, newWind);
      }
    }

    return microData;
  }
}
