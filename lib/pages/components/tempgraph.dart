import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TempGraph extends StatelessWidget {
  const TempGraph({super.key, required this.todos, required this.duration});
  final List<FlSpot>? todos;
  final double? duration;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: .95,
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

  Widget tempLeftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case -25:
        text = '-25';
        break;
      case 0:
        text = '0';
        break;
      case 25:
        text = '25';
        break;
      case 50:
        text = '50';
        break;
      case 75:
        text = '75';
        break;
      case 100:
        text = '100';
        break;
      case 125:
        text = '125';
        break;
      default:
        return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.center);
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 13,
    );
    Widget text;
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
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  LineChartData graphData(double? maxX) {
    List<Color> tempColors = [
      Color.fromARGB(255, 255, 255, 0),
      Color.fromARGB(255, 226, 105, 0),
    ];

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 25,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.white10,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.white10,
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
          sideTitles: SideTitles(showTitles: true, reservedSize: 7),
          axisNameSize: 45,
          axisNameWidget: const Text(
            'Temperature',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 27),
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
          axisNameWidget: const Text(
            'Days',
            style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: tempLeftTitleWidgets,
            reservedSize: 32,
          ),
          axisNameWidget: const Text(
            'Degrees (°F)',
            style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 4),
      ),
      minX: 0,
      maxX: maxX,
      minY: -50,
      maxY: 150,
      lineBarsData: [
        LineChartBarData(
          spots: todos,
          isCurved: false,
          gradient: LinearGradient(
            colors: tempColors,
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
                  tempColors.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
