import 'package:caliweather/util/sql_helper.dart';
import '../util/sharedprefutil.dart';
import 'globals.dart' as globals;
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class WeatherHelper {
  // Current Weather
  static Future<Weather> getCurrent() async {
    WeatherFactory wf = WeatherFactory(globals.apiKey);
    Weather weather = await wf.currentWeatherByLocation(
        globals.positionLat, globals.positionLong);
    return weather;
  }

  // 5-Day Forecast
  static Future<List<dynamic>> setForecast() async {
    WeatherFactory wf = WeatherFactory(globals.apiKey);
    List<dynamic> setData = [];
    List<dynamic> forecast = await wf.fiveDayForecastByLocation(
        globals.positionLat, globals.positionLong);
    setData = [
      forecast[7], // <-- Day 1
      forecast[15], // <-- Day 2
      forecast[23], // <-- Day 3
      forecast[31], // <-- Day 4
      forecast[39] // <-- Day 5
    ];
    return setData;
  }

  static Future<List> getForecast() async {
    List<dynamic> formatData = [[], [], [], [], []];
    List<dynamic> forecastData = await setForecast();
    for (int i = 0; i < 5; i++) {
      DateTime? formatDate = forecastData[i].date;
      String? temp =
          forecastData[i].temperature?.fahrenheit?.toStringAsFixed(0)!;
      String desc = forecastData[i].weatherMain.toString();
      String icon = forecastData[i].weatherIcon.toString();
      String date = DateFormat('MMM dd').format(formatDate!);
      formatData[i] = [temp, desc, date, icon];
    }
    return formatData;
  }

  static Future<List> getMainweather() async {
    Weather weather = await WeatherHelper.getCurrent();
    DateTime? formatDate = weather.date;

    String weatherIcon = weather.weatherIcon.toString();
    String? temperature =
        (weather.temperature?.fahrenheit?.toStringAsFixed(0))!;
    String weatherMain = weather.weatherMain.toString();
    String areaName = weather.areaName.toString();
    String date = DateFormat('MMM dd').format(formatDate!);

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
    Weather weather = await WeatherHelper.getCurrent();

    DateTime? formatSunrise = weather.sunrise;
    DateTime? formatSunset = weather.sunset;
    String sunrise = DateFormat.jm().format(formatSunrise!);
    String sunset = DateFormat.jm().format(formatSunset!);

    String areaName = weather.areaName.toString();
    String cloudiness = "${weather.cloudiness}%";
    String country = weather.country.toString();
    String date = weather.date.toString();
    String humidity = "${weather.humidity}%";
    String latitude = weather.latitude.toString();
    String longitude = weather.longitude.toString();
    String pressure = "${weather.pressure} hPa";
    String rainLast3Hours = "${weather.rainLast3Hours} mm";
    String rainLastHour = "${weather.rainLastHour} mm";
    String snowLast3Hours = "${weather.snowLast3Hours} mm";
    String snowLastHour = "${weather.snowLastHour} mm";

    // TODO: Pull temp units from settings/database.
    String? tempFeelsLike =
        "${(weather.tempFeelsLike?.fahrenheit?.toStringAsFixed(1))!} °F";
    String? tempMax =
        "${(weather.tempMax?.fahrenheit?.toStringAsFixed(1))!} °F";
    String? tempMin =
        "${(weather.tempMin?.fahrenheit?.toStringAsFixed(1))!} °F";
    String? temperature =
        "${(weather.temperature?.fahrenheit?.toStringAsFixed(1))!} °F";

    String weatherConditionCode = weather.weatherConditionCode.toString();
    String weatherDescription = weather.weatherDescription.toString();
    String weatherIcon = weather.weatherIcon.toString();
    String weatherMain = weather.weatherMain.toString();
    String windDegree = weather.windDegree.toString();
    String windGust = weather.windGust.toString();
    String windSpeed = weather.windSpeed.toString();

    List<String?> microData = [
      areaName,
      cloudiness,
      country,
      date,
      humidity,
      latitude,
      longitude,
      pressure,
      rainLast3Hours,
      rainLastHour,
      snowLast3Hours,
      snowLastHour,
      sunrise,
      sunset,
      tempFeelsLike,
      tempMax,
      tempMin,
      temperature,
      weatherConditionCode,
      weatherDescription,
      weatherIcon,
      weatherMain,
      windDegree,
      windGust,
      windSpeed
    ];

    int? userId = SharedPrefUtil.getUserId();
    
    String? temp = weather.temperature?.fahrenheit.toString();
    String formatTemp = temp!.replaceAll('Fahrenheit', '');
    double? doubleTemp = double.parse(formatTemp);
    double newTemp = double.parse(doubleTemp.toStringAsFixed(1));

    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String apiCallDate = dateFormat.format(DateTime.now());

    SQLHelper.createWeatherData(userId, apiCallDate, weather.areaName,
        weather.rainLastHour, newTemp, weather.humidity, weather.snowLastHour);

    return microData;
  }
}
