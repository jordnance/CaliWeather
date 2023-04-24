import 'package:caliweather/util/sql_helper.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import '../util/sharedprefutil.dart';
import 'dart:developer' as developer;

class WeatherHelper {
  static Future<List<dynamic>?> getGeoName() async {
    http.Response geoNameResponse = await http.get(
      Uri.https('api.openweathermap.org', '/geo/1.0/reverse', {
        'lat': SharedPrefUtil.getLatitude().toString(),
        'lon': SharedPrefUtil.getLongitude().toString(),
        'appid': '0d8187b327e042982d4478dcbf90bae3',
      }),
    );

    if (geoNameResponse.statusCode != 200) {
      developer.log(
        geoNameResponse.statusCode.toString(),
        name: 'geoNameResponse.statusCode.error',
      );
      return null;
    }

    List<dynamic> g = jsonDecode(geoNameResponse.body);
    return g;
  }

  static Future<List<dynamic>?> getGeoCoords() async {
    http.Response geoCoordsResponse = await http.get(
      Uri.https('api.openweathermap.org', '/geo/1.0/direct', {
        'q': SharedPrefUtil.getLocation(),
        'appid': '0d8187b327e042982d4478dcbf90bae3',
      }),
    );

    if (geoCoordsResponse.statusCode != 200) {
      developer.log(
        geoCoordsResponse.statusCode.toString(),
        name: 'geoNameResponse.statusCode.error',
      );
      return null;
    }

    List<dynamic> c = jsonDecode(geoCoordsResponse.body);
    return c;
  }

  static Future<Map<String, dynamic>?> getCurrent() async {
    var lang;
    if (SharedPrefUtil.getIsLoggedIn()) {
      if (!SharedPrefUtil.getIsServiceEnabled()) {
        var geo = await WeatherHelper.getGeoCoords();
        if (geo != null) {
          SharedPrefUtil.setLatitude(geo[0]['lat']);
          SharedPrefUtil.setLongitude(geo[0]['lon']);
        }
      }
    }

    if (SharedPrefUtil.getLanguage() == 'English') {
      lang = 'en';
    } else if (SharedPrefUtil.getLanguage() == 'Spanish') {
      lang = 'sp';
    }

    http.Response weatherResponse = await http.get(
      Uri.https('api.openweathermap.org', '/data/3.0/onecall', {
        'lat': SharedPrefUtil.getLatitude().toString(),
        'lon': SharedPrefUtil.getLongitude().toString(),
        'exclude': 'hourly,minutely',
        'appid': '0d8187b327e042982d4478dcbf90bae3',
        'units': 'imperial',
        'lang': lang,
      }),
    );

    if (weatherResponse.statusCode != 200) {
      developer.log(
        weatherResponse.statusCode.toString(),
        name: 'geoNameResponse.statusCode.error',
      );
      return null;
    }

    Map<String, dynamic> w = jsonDecode(weatherResponse.body);
    return w;
  }

  static Future<List> getForecast(Map<String, dynamic> weather) async {
    List<dynamic> forecast = [];
    List<dynamic> forecastData = [];
    List<dynamic> formatData = [[], [], [], [], [], [], [], []];

    for (int i = 0; i < 8; i++) {
      forecast.insert(i, weather['daily'][i]);
      forecastData.insert(i, forecast[i]);
    }

    for (int i = 0; i < 8; i++) {
      DateTime formatDate =
          DateTime.fromMillisecondsSinceEpoch(forecastData[i]['dt'] * 1000);
      String temp = forecastData[i]['temp']['day'].toStringAsFixed(0)!;
      String desc = forecastData[i]['weather'][0]['main'].toString();
      String icon = forecastData[i]['weather'][0]['icon'].toString();
      String date = DateFormat('MMM dd').format(formatDate);
      formatData[i] = [temp, desc, date, icon];
    }

    return formatData;
  }

  static Future<List> getMainweather(Map<String, dynamic> weather) async {
    var geo = await getGeoName();

    DateTime formatDate =
        DateTime.fromMillisecondsSinceEpoch(weather['current']['dt'] * 1000);
    String date = DateFormat('MMM dd').format(formatDate);

    String weatherIcon = weather['current']['weather'][0]['icon'];
    String temperature = weather['current']['temp'].toStringAsFixed(0);
    String weatherMain = weather['current']['weather'][0]['main'];
    String areaName = geo![0]['name'];

    date = DateFormat('MMM dd').format(formatDate);

    List<String> mainData = [
      weatherIcon,
      temperature,
      weatherMain,
      areaName,
      date
    ];

    return mainData;
  }

  static Future<List> getMicroweather(Map<String, dynamic> weather) async {
    var geo = await getGeoName();

    DateTime formatSunrise = DateTime.fromMillisecondsSinceEpoch(
        weather['current']['sunrise'] * 1000);
    DateTime formatSunset = DateTime.fromMillisecondsSinceEpoch(
        weather['current']['sunset'] * 1000);

    String sunrise = DateFormat.jm().format(formatSunrise);
    String sunset = DateFormat.jm().format(formatSunset);

    String areaName = geo![0]['name'];
    String cloudiness = "${weather['current']['clouds']}%";
    String dewPoint =
        "${weather['current']['dew_point'].toStringAsFixed(0)} °F";
    String humidity = "${weather['current']['humidity']}%";
    String pressure =
        "${weather['current']['pressure'].toStringAsFixed(0)} hPa";
    String tempFeelsLike =
        "${weather['current']['feels_like'].toStringAsFixed(0)} °F";
    String temperature =
        "${(weather['current']['temp'].toStringAsFixed(1))!} °F";
    String uvi = "${weather['current']['uvi'].toStringAsFixed(0)} of 10";
    String weatherDescription =
        weather['current']['weather'][0]['description'].toString();
    weatherDescription = weatherDescription.replaceFirst(
        weatherDescription[0], weatherDescription[0].toUpperCase());
    String windSpeed =
        "${weather['current']['wind_speed'].toStringAsFixed(0)} mph";

    List<String> microData = [
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

    String? rainLastHour;
    if (weather['current']['rain'] != null) {
      rainLastHour = "${weather['current']['rain']['1h']}";
    } else {
      rainLastHour = '0';
    }

    String? snowLastHour;
    if (weather['current']['snow'] != null) {
      rainLastHour = "${weather['current']['snow']['1h']}";
    } else {
      snowLastHour = '0';
    }

    if (SharedPrefUtil.getIsLoggedIn()) {
      int userId = SharedPrefUtil.getUserId();
      var getFreq = await SQLHelper.getFrequency(userId);
      var frequency = getFreq[0]['COUNT(*)'];

      if (frequency == 0) {
        String formatTemp = temperature.replaceAll('°F', '');
        double doubleTemp = double.parse(formatTemp);
        double newTemp = double.parse(doubleTemp.toStringAsFixed(1));

        DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
        String apiCallDate = dateFormat.format(DateTime.now());

        double doubleRain = double.parse(rainLastHour);
        double newRain = double.parse(doubleRain.toStringAsFixed(1));

        String formatHum = humidity.replaceAll('%', '');
        double doubleHum = double.parse(formatHum);
        double newHum = double.parse(doubleHum.toStringAsFixed(1));

        double doubleSnow = double.parse(snowLastHour!);
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
