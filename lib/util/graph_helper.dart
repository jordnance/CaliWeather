import '../util/sql_helper.dart';
import '../util/sharedprefutil.dart';
import 'package:fl_chart/fl_chart.dart';

class GraphHelper {
  static Future<List<double>> getXCoords() async {
    var test = await SQLHelper.getUserData(SharedPrefUtil.getUserId());
    var leastCurrent = test[0]['apiCallDate'];

    var thisTime, difference, parsedLeastCurrent, parsedThisTime;
    double seconds, newX = 0;
    List<double> xCoords = [];

    for (int i = 0; i < test.length; i++) {
      thisTime = test[i]['apiCallDate'];
      parsedThisTime = DateTime.parse(thisTime);
      parsedLeastCurrent = DateTime.parse(leastCurrent);
      difference = parsedThisTime.difference(parsedLeastCurrent);
      seconds = difference.inSeconds.toDouble();
      newX = seconds / 86400;
      xCoords.add(newX);
    }

    return xCoords;
  }

  static Future<List<List<double>>> getYCoords() async {
    var test = await SQLHelper.getUserData(SharedPrefUtil.getUserId());
    double? yRain, yTemp, yHum, ySnow, yWind, yPress;
    List<double> values = [];
    List<List<double>> yCoords = [];

    for (int i = 0; i < test.length; i++) {
      yRain = test[i]['rain'];
      yRain ??= 0;
      yTemp = test[i]['temp'];
      yHum = test[i]['humidity'];
      ySnow = test[i]['snow'];
      ySnow ??= 0;
      yWind = test[i]['windSpeed'];
      yPress = test[i]['pressure'];
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
      var test = await SQLHelper.getUserData(SharedPrefUtil.getUserId());

      if (test.isNotEmpty) {
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
