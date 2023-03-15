import '../util/sql_helper.dart';
import '../util/sharedprefutil.dart';
import 'package:fl_chart/fl_chart.dart';

class GraphHelper {
  static Future<List<double>> getXCoords(double? durationLength) async {
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
      if (newX <= durationLength!) {
        xCoords.add(newX);
      }
    }
    return xCoords;
  }

  static Future<List<List<double>>> getYCoords() async {
    var test = await SQLHelper.getUserData(SharedPrefUtil.getUserId());
    double? yRain, yTemp, yHum, ySnow;
    List<double> values = [];
    List<List<double>> yCoords = [];

    for (int i = 0; i < test.length; i++) {
      yRain = test[i]['rain'];
      yRain ??= 0;
      yTemp = test[i]['temp'];
      yHum = test[i]['humidity'];
      ySnow = test[i]['snow'];
      ySnow ??= 0;
      values.add(yRain);
      values.add(yTemp!);
      values.add(yHum!);
      values.add(ySnow);
      yCoords.add(values);
      values = [];
    }
    return yCoords;
  }

  static Future<List<List<FlSpot>>> newCoords(double? durationLength) async {
    if (SharedPrefUtil.getUserId() != 0) {
      var xCoords = await getXCoords(durationLength);
      var yCoords = await getYCoords();
      List<List<FlSpot>> newCoords = [];
      List<FlSpot> rainData = [];
      List<FlSpot> tempData = [];
      List<FlSpot> humData = [];
      List<FlSpot> snowData = [];

      for (int i = 0; i < xCoords.length; i++) {
        rainData.add(FlSpot(xCoords[i], yCoords[i][0]));
        tempData.add(FlSpot(xCoords[i], yCoords[i][1]));
        humData.add(FlSpot(xCoords[i], yCoords[i][2]));
        snowData.add(FlSpot(xCoords[i], yCoords[i][3]));
      }

      newCoords = [rainData, tempData, humData, snowData];
      return newCoords;
    } else {
      return Future.error('User is not logged in');
    }
  }
}
