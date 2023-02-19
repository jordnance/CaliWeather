import 'globals.dart' as globals;
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
  static Future<Weather> getForecast(int day) async {
    WeatherFactory wf = WeatherFactory(globals.apiKey);
    // Day 0: forecast[0], Day 1: forecast[8], Day 2: forecast[16],
    // Day 3: forecast[24], Day 4: forecast[32], Day 5: forecast[40]
    if (day > 0 && day <= 5) {
      List<Weather> forecast = await wf.fiveDayForecastByLocation(
          globals.positionLat, globals.positionLong);
      return forecast[day * 8];
    } else {
      throw("Forecast is limited to days 0-5. Try again");
    }
  }
}
