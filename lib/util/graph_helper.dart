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
    bool equalDuration = false;

    for (int i = 0; i < test.length; i++) {
      thisTime = test[i]['apiCallDate'];
      parsedThisTime = DateTime.parse(thisTime);
      parsedLeastCurrent = DateTime.parse(leastCurrent);
      difference = parsedThisTime.difference(parsedLeastCurrent);
      seconds = difference.inSeconds.toDouble();
      newX = seconds / 86400;

      if (newX < durationLength!) {
        xCoords.add(newX);
      } else if (newX == durationLength) {
        xCoords.add(newX);
        equalDuration = true;
      } else if (!equalDuration) {
        newX = durationLength;
        xCoords.add(newX);
      }
    }

    return xCoords;
  }

  static Future<List<List<double>>> getYCoords(double? durationLength) async {
    var test = await SQLHelper.getUserData(SharedPrefUtil.getUserId());
    var leastCurrent = test[0]['apiCallDate'];

    var thisTime, difference, parsedLeastCurrent, parsedThisTime;
    double xValue, seconds, xFactor, lastX = 0;
    double? yRain,
        yTemp,
        yHum,
        ySnow,
        yWind,
        yPress,
        lastYRain,
        lastYTemp,
        lastYHum,
        lastYSnow,
        lastYWind,
        lastYPress,
        avgYRain,
        avgYTemp,
        avgYHum,
        avgYSnow,
        avgYWind,
        avgYPress;

    List<double> values = [];
    List<List<double>> yCoords = [];
    bool equalDuration = false;
    bool graphFix = false;

    for (int i = 0; i < test.length; i++) {
      thisTime = test[i]['apiCallDate'];
      parsedThisTime = DateTime.parse(thisTime);
      parsedLeastCurrent = DateTime.parse(leastCurrent);
      difference = parsedThisTime.difference(parsedLeastCurrent);
      seconds = difference.inSeconds.toDouble();
      xValue = seconds / 86400;

      yRain = test[i]['rain'];
      yRain ??= 0;
      yTemp = test[i]['temp'];
      yHum = test[i]['humidity'];
      ySnow = test[i]['snow'];
      ySnow ??= 0;
      yWind = test[i]['windSpeed'];
      yPress = test[i]['pressure'];

      if (xValue == durationLength) {
        equalDuration = true;
      }

      if (xValue <= durationLength!) {
        lastYRain = yRain;
        lastYTemp = yTemp;
        lastYHum = yHum;
        lastYSnow = ySnow;
        lastYWind = yWind;
        lastYPress = yPress;
        values.add(yRain);
        values.add(yTemp!);
        values.add(yHum!);
        values.add(ySnow);
        values.add(yWind!);
        values.add(yPress!);
        lastX = xValue;
      } else if (!equalDuration && (xValue > durationLength) && !graphFix) {
        xFactor = (xValue + lastX) / durationLength;
        avgYRain = ((yRain + lastYRain!) / xFactor);
        avgYTemp = ((yTemp! + lastYTemp!) / xFactor);
        avgYHum = ((yHum! + lastYHum!) / xFactor);
        avgYSnow = ((ySnow + lastYSnow!) / xFactor);
        avgYWind = ((yWind! + lastYWind!) / xFactor);
        avgYPress = ((yPress! + lastYPress!) / xFactor);
        values.add(avgYRain);
        values.add(avgYTemp);
        values.add(avgYHum);
        values.add(avgYSnow);
        values.add(avgYWind);
        values.add(avgYPress);
        graphFix = true;
      }

      yCoords.add(values);
      values = [];
    }
    return yCoords;
  }

  static Future<List<List<FlSpot>>> newCoords(double? durationLength) async {
    if (SharedPrefUtil.getIsLoggedIn()) {
      var test = await SQLHelper.getUserData(SharedPrefUtil.getUserId());

      if (test.isNotEmpty) {
        var xCoords = await getXCoords(durationLength);
        var yCoords = await getYCoords(durationLength);
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
