import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HumGraph extends StatelessWidget {
  const HumGraph({super.key, required this.todos});
  final List<FlSpot>? todos;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1.50,
        child: Padding(
          padding: const EdgeInsets.only(
            right: 18,
            left: 12,
            top: 24,
            bottom: 12,
          ),
          child: LineChart(
            graphData(),
          ),
        ),
      ),
    );
  }

  Widget humLeftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 13,
    );
    String text;
    switch (value.toInt()) {
      case 10:
        text = '10';
        break;
      case 20:
        text = '';
        break;
      case 30:
        text = '30';
        break;
      case 40:
        text = '';
        break;
      case 50:
        text = '50';
        break;
      case 60:
        text = '';
        break;
      case 70:
        text = '70';
        break;
      case 80:
        text = '';
        break;
      case 90:
        text = '90';
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
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  LineChartData graphData() {
    List<Color> humColors = [
      Color.fromARGB(255, 65, 255, 77),
      Color.fromARGB(255, 0, 102, 19),
    ];

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 10,
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
          axisNameSize: 20,
          axisNameWidget: const Text(
            'Humidity',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w900, fontSize: 17),
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
            getTitlesWidget: humLeftTitleWidgets,
            reservedSize: 34,
          ),
          axisNameWidget: const Text(
            'Percent (%)',
            style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 4),
      ),
      minX: 0,
      maxX: 14,
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          spots: todos,
          isCurved: true,
          gradient: LinearGradient(
            colors: humColors,
          ),
          barWidth: 6,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: humColors.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
