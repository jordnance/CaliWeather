import '../util/sharedprefutil.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:caliweather/util/graph_helper.dart';
import 'package:caliweather/pages/components/raingraph.dart';
import 'package:caliweather/pages/components/tempgraph.dart';
import 'package:caliweather/pages/components/humgraph.dart';
import 'package:caliweather/pages/components/snowgraph.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:caliweather/pages/components/windgraph.dart';
import 'package:caliweather/pages/components/pressgraph.dart';

class Todo {
  final String rainData;
  final String tempData;
  final String humData;
  final String snowData;
  final String pressData;
  final String windData;
  final String duration;

  const Todo(this.rainData, this.tempData, this.humData, this.snowData,
      this.pressData, this.windData, this.duration);
}

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key, required this.title});
  final String title;

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  List<FlSpot>? rain;
  List<FlSpot>? temp;
  List<FlSpot>? hum;
  List<FlSpot>? snow;
  List<FlSpot>? wind;
  List<FlSpot>? press;
  double? length;
  Color pgBackgroundColor = Colors.grey.shade200;

  Future<void> getData() async {
    if (SharedPrefUtil.getIsLoggedIn() == true) {
      List<List<FlSpot>> data = await GraphHelper.newCoords();
      rain = data[0];
      temp = data[1];
      hum = data[2];
      snow = data[3];
      wind = data[4];
      press = data[5];
      length = data[0].last.x;
    } else {
      List<FlSpot> dummyRain = [
        const FlSpot(0, 0),
        const FlSpot(1, 1),
        const FlSpot(2, 4.5),
        const FlSpot(3, 3),
        const FlSpot(4, 4),
        const FlSpot(5, 2),
        const FlSpot(6, 2),
        const FlSpot(7, 1),
        const FlSpot(8, 2),
        const FlSpot(9, 1),
        const FlSpot(10, 2),
        const FlSpot(11, 4.5),
        const FlSpot(12, 2),
        const FlSpot(13, 4),
        const FlSpot(14, 2),
      ];

      List<FlSpot> dummyTemp = [
        const FlSpot(0, 50),
        const FlSpot(1, 55),
        const FlSpot(2, 60),
        const FlSpot(3, 62),
        const FlSpot(4, 68),
        const FlSpot(5, 58),
        const FlSpot(6, 65),
        const FlSpot(7, 70),
        const FlSpot(8, 72),
        const FlSpot(9, 63),
        const FlSpot(10, 67),
        const FlSpot(11, 58),
        const FlSpot(12, 75),
        const FlSpot(13, 65),
        const FlSpot(14, 70),
      ];

      List<FlSpot> dummyHum = [
        const FlSpot(0, 50),
        const FlSpot(1, 67),
        const FlSpot(2, 60),
        const FlSpot(3, 62),
        const FlSpot(4, 68),
        const FlSpot(5, 58),
        const FlSpot(6, 65),
        const FlSpot(7, 80),
        const FlSpot(8, 72),
        const FlSpot(9, 63),
        const FlSpot(10, 70),
        const FlSpot(11, 58),
        const FlSpot(12, 75),
        const FlSpot(13, 85),
        const FlSpot(14, 70),
      ];

      List<FlSpot> dummySnow = [
        const FlSpot(0, 0),
        const FlSpot(1, 1),
        const FlSpot(2, 3),
        const FlSpot(3, 3.5),
        const FlSpot(4, 3),
        const FlSpot(5, 1),
        const FlSpot(6, 1),
        const FlSpot(7, 0.5),
        const FlSpot(8, 1),
        const FlSpot(9, 0.5),
        const FlSpot(10, 1),
        const FlSpot(11, 2),
        const FlSpot(12, 3),
        const FlSpot(13, 2.5),
        const FlSpot(14, 1),
      ];

      List<FlSpot> dummyWind = [
        const FlSpot(0, 0),
        const FlSpot(1, 1),
        const FlSpot(2, 4.5),
        const FlSpot(3, 3),
        const FlSpot(4, 4),
        const FlSpot(5, 2),
        const FlSpot(6, 2),
        const FlSpot(7, 1),
        const FlSpot(8, 2),
        const FlSpot(9, 1),
        const FlSpot(10, 2),
        const FlSpot(11, 4.5),
        const FlSpot(12, 2),
        const FlSpot(13, 4),
        const FlSpot(14, 2),
      ];

      List<FlSpot> dummyPress = [
        const FlSpot(0, 1000),
        const FlSpot(1, 1010),
        const FlSpot(2, 1005),
        const FlSpot(3, 1020),
        const FlSpot(4, 1018),
        const FlSpot(5, 1015),
        const FlSpot(6, 1022),
        const FlSpot(7, 1020),
        const FlSpot(8, 1013),
        const FlSpot(9, 1010),
        const FlSpot(10, 1007),
        const FlSpot(11, 1011),
        const FlSpot(12, 1009),
        const FlSpot(13, 1018),
        const FlSpot(14, 1016),
      ];

      rain = dummyRain;
      temp = dummyTemp;
      hum = dummyHum;
      snow = dummySnow;
      wind = dummyWind;
      press = dummyPress;
      length = dummyTemp.last.x;
    }
  }

  @override
  Widget build(BuildContext context) {
    final PageController pgController = PageController();
    final PageController pg2Controller = PageController();

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: FutureBuilder<void>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(
                  child: Text("None"),
                );
              case ConnectionState.waiting:
                return const Center(
                  child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator()),
                );
              case ConnectionState.active:
                return const Center(child: Text("Active"));
              case ConnectionState.done:
                return Column(
                  children: <Widget>[
                    const Center(
                      child: SizedBox(
                        height: 30,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: PageView(
                          controller: pgController,
                          children: <Widget>[
                            TempGraph(todos: temp, duration: length),
                            HumGraph(todos: hum, duration: length),
                            PressGraph(todos: press, duration: length)
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: pgController,
                        count: 3,
                        axisDirection: Axis.horizontal,
                        effect: SlideEffect(
                          activeDotColor: Colors.blueGrey,
                          dotHeight: 10,
                          dotColor: Colors.grey.shade400,
                          dotWidth: 10,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: PageView(
                          controller: pg2Controller,
                          children: <Widget>[
                            WindGraph(todos: wind, duration: length),
                            RainGraph(todos: rain, duration: length),
                            SnowGraph(todos: snow, duration: length),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: pg2Controller,
                        count: 3,
                        axisDirection: Axis.horizontal,
                        effect: SlideEffect(
                          activeDotColor: Colors.blueGrey,
                          dotHeight: 10,
                          dotColor: Colors.grey.shade400,
                          dotWidth: 10,
                        ),
                      ),
                    ),
                    const Center(
                      child: SizedBox(
                        height: 70,
                      ),
                    ),
                  ],
                );
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            right: 10,
            bottom: 10,
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              tooltip: 'Refresh',
              onPressed: () {
                setState(() {});
              },
              child: const Icon(
                Icons.refresh_rounded,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
