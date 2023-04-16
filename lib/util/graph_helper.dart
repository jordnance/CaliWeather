import '../util/sql_helper.dart';
import '../util/sharedprefutil.dart';
import 'package:fl_chart/fl_chart.dart';

class GraphHelper {
  static Future<List<double>> getXCoords() async {
    var data = await SQLHelper.getUserData(SharedPrefUtil.getUserId());
    var mostCurrent = data[data.length - 1]['apiCallDate'];

    // ignore: prefer_typing_uninitialized_variables
    var thisTime, difference, parsedMostCurrent, parsedThisTime;
    double seconds, newX = 0;
    List<double> xCoords = [];

    for (int i = data.length - 1; i > -1; i--) {
      thisTime = data[i]['apiCallDate'];
      parsedThisTime = DateTime.parse(thisTime);
      parsedMostCurrent = DateTime.parse(mostCurrent);
      difference = parsedThisTime.difference(parsedMostCurrent);
      seconds = difference.inSeconds.toDouble();
      newX = (seconds / 86400) * -1;
      xCoords.add(newX);
    }

    return xCoords;
  }

  static Future<List<List<double>>> getYCoords() async {
    var data = await SQLHelper.getUserData(SharedPrefUtil.getUserId());
    double? yRain, yTemp, yHum, ySnow, yWind, yPress;
    List<double> values = [];
    List<List<double>> yCoords = [];

    for (int i = data.length - 1; i > -1; i--) {
      yRain = data[i]['rain'];
      yRain ??= 0;
      yTemp = data[i]['temp'];
      yHum = data[i]['humidity'];
      ySnow = data[i]['snow'];
      ySnow ??= 0;
      yWind = data[i]['windSpeed'];
      yPress = data[i]['pressure'];
      values.add(yRain);
      values.add(yTemp!);
      values.add(yHum!);
      values.add(ySnow);
      values.add(yWind!);
      values.add(yPress!);
      yCoords.add(values);
      values = [];
    }

    return yCoords;
  }

  static Future<List<List<FlSpot>>> newCoords() async {
    if (SharedPrefUtil.getIsLoggedIn()) {
      var data = await SQLHelper.getUserData(SharedPrefUtil.getUserId());

      if (data.isNotEmpty) {
        var xCoords = await getXCoords();
        var yCoords = await getYCoords();
        List<List<FlSpot>> newCoords = [];
        List<FlSpot> rainData = [];
        List<FlSpot> tempData = [];
        List<FlSpot> humData = [];
        List<FlSpot> snowData = [];
        List<FlSpot> windData = [];
        List<FlSpot> pressData = [];

        for (int i = 0; i < xCoords.length; i++) {
          rainData.add(FlSpot(xCoords[i], yCoords[i][0]));
          tempData.add(FlSpot(xCoords[i], yCoords[i][1]));
          humData.add(FlSpot(xCoords[i], yCoords[i][2]));
          snowData.add(FlSpot(xCoords[i], yCoords[i][3]));
          windData.add(FlSpot(xCoords[i], yCoords[i][4]));
          pressData.add(FlSpot(xCoords[i], yCoords[i][5]));
        }

        newCoords = [
          rainData,
          tempData,
          humData,
          snowData,
          windData,
          pressData
        ];

        return newCoords;
      } else {
        return Future.error('No weather data has been stored');
      }
    } else {
      return Future.error('User is not logged in');
    }
  }
}
