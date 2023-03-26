import 'package:caliweather/util/sql_helper.dart';
import '../util/sharedprefutil.dart';
import 'globals.dart' as globals;
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class WeatherHelper {
  static Future<Weather> getCurrent(WeatherFactory wf) async {
    Weather weather;
    weather = await wf.currentWeatherByLocation(
        globals.positionLat, globals.positionLong);

    if (SharedPrefUtil.getIsLoggedIn() == true) {
      SQLHelper.updateLocation(
          SharedPrefUtil.getUserPrefId(), weather.areaName!);
      SharedPrefUtil.setLocation(weather.areaName!);
    }

    return weather;
  }

  static Future<List<dynamic>> setForecast(WeatherFactory wf) async {
    List<dynamic> setData = [];
    List<dynamic> forecast;

    if (SharedPrefUtil.getIsLoggedIn() == false) {
      forecast = await wf.fiveDayForecastByLocation(
          globals.positionLat, globals.positionLong);
    } else {
      forecast =
          await wf.fiveDayForecastByCityName(SharedPrefUtil.getLocation());
    }

    setData = [
      forecast[7], // <-- Day 1
      forecast[15], // <-- Day 2
      forecast[23], // <-- Day 3
      forecast[31], // <-- Day 4
      forecast[39] // <-- Day 5
    ];
    return setData;
  }

  static Future<List> getForecast(WeatherFactory wf) async {
    List<dynamic> formatData = [[], [], [], [], []];
    List<dynamic> forecastData = await setForecast(wf);
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

  static Future<List> getMainweather(WeatherFactory wf) async {
    Weather weather = await WeatherHelper.getCurrent(wf);
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

  static Future<List> getMicroweather(WeatherFactory wf) async {
    Weather weather = await WeatherHelper.getCurrent(wf);

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
    String pressure = "${weather.pressure?.toStringAsFixed(0)} hPa";
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
    weatherDescription = weatherDescription.replaceFirst(
        weatherDescription[0], weatherDescription[0].toUpperCase());
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

    SQLHelper.createWeatherData(
        userId,
        apiCallDate,
        weather.areaName,
        weather.rainLastHour,
        newTemp,
        weather.humidity,
        weather.snowLastHour,
        weather.pressure,
        weather.windSpeed);

    return microData;
  }
}
