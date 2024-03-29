import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WindGraph extends StatelessWidget {
  const WindGraph({super.key, required this.todos, required this.duration});
  final List<FlSpot>? todos;
  final double? duration;
  static const Color textColor = Colors.black87;
  static const Color graphBgColor = Color(0xFF212121); //grey.shae900
  static const Color graphGridLineColor = Colors.white10;
  static const Color graphBorderLineColor = Color(0xff37434d); //blue-grey
  static const Color graphLineGradientColor1 =
      Color.fromARGB(255, 253, 175, 223);
  static const Color graphLineGradientColor2 =
      Color.fromARGB(255, 250, 13, 160);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Padding(
          padding: const EdgeInsets.only(
            right: 24,
            left: 12,
            top: 12,
            bottom: 30,
          ),
          child: LineChart(
            graphData(duration),
          ),
        ),
      ),
    );
  }

  Widget windLeftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      color: textColor,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 10:
        text = '10';
        break;
      case 20:
        text = '20';
        break;
      case 30:
        text = '30';
        break;
      case 40:
        text = '40';
        break;
      case 50:
        text = '50';
        break;
      default:
        return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.center);
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      color: textColor,
      fontSize: 13,
    );
    Widget text;
    if (value % 1 == 0) {
      switch (value.toInt()) {
        case 0:
          text = const Text('0', style: style);
          break;
        case 1:
          text = const Text('1', style: style);
          break;
        case 2:
          text = const Text('2', style: style);
          break;
        case 3:
          text = const Text('3', style: style);
          break;
        case 4:
          text = const Text('4', style: style);
          break;
        case 5:
          text = const Text('5', style: style);
          break;
        case 6:
          text = const Text('6', style: style);
          break;
        case 7:
          text = const Text('7', style: style);
          break;
        case 8:
          text = const Text('8', style: style);
          break;
        case 9:
          text = const Text('9', style: style);
          break;
        case 10:
          text = const Text('10', style: style);
          break;
        case 11:
          text = const Text('11', style: style);
          break;
        case 12:
          text = const Text('12', style: style);
          break;
        case 13:
          text = const Text('13', style: style);
          break;
        case 14:
          text = const Text('14', style: style);
          break;
        default:
          text = const Text('', style: style);
          break;
      }
    } else {
      text = const Text('', style: style);
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  LineChartData graphData(double? maxX) {
    List<Color> windColors = [
      graphLineGradientColor1,
      graphLineGradientColor2,
    ];

    return LineChartData(
      backgroundColor: graphBgColor,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 10,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: graphGridLineColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: graphGridLineColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, reservedSize: 4),
          axisNameSize: 45,
          axisNameWidget: const Text('Wind',
              style: TextStyle(
                  color: textColor, fontWeight: FontWeight.w500, fontSize: 25)),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
          axisNameWidget: const Text(
            'Days',
            style: TextStyle(color: textColor, fontStyle: FontStyle.italic),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: windLeftTitleWidgets,
            reservedSize: 28,
          ),
          axisNameWidget: const Text(
            'Speed (mph)',
            style: TextStyle(color: textColor, fontStyle: FontStyle.italic),
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: graphBorderLineColor, width: 4),
      ),
      minX: 0,
      maxX: maxX,
      minY: 0,
      maxY: 60,
      lineBarsData: [
        LineChartBarData(
          spots: todos,
          isCurved: false,
          gradient: LinearGradient(
            colors: windColors,
          ),
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors:
                  windColors.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
