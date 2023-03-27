import '../util/sharedprefutil.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:caliweather/util/graph_helper.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
  double? length = 14;
  bool? isPressed = false;
  int durationIndex = 1;
  int titleIndex = 0;
  List<String> durationTitle = ['2 Weeks', '1 Week', '3 Days'];

  Future<void> getData(double? durationLength) async {
    if (SharedPrefUtil.getIsLoggedIn() == true) {
      List<List<FlSpot>> data = await GraphHelper.newCoords(durationLength);
      rain = data[0];
      temp = data[1];
      hum = data[2];
      snow = data[3];
      wind = data[4];
      press = data[5];
    }
  }

  void changeDuration() {
    if (titleIndex != 2) {
      titleIndex++;
    } else {
      titleIndex = 0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final PageController pgController = PageController();
    final PageController pg2Controller = PageController();

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: FutureBuilder<void>(
          future: getData(length),
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
            child: SpeedDial(
              spacing: 8,
              spaceBetweenChildren: 8,
              animatedIcon: AnimatedIcons.menu_close,
              animatedIconTheme: const IconThemeData(size: 22.0),
              closeManually: false,
              curve: Curves.bounceIn,
              overlayColor: Colors.black,
              overlayOpacity: 0.5,
              tooltip: 'Change Duration',
              heroTag: 'speed-dial-hero-tag',
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 8.0,
              shape: const CircleBorder(),
              children: [
                SpeedDialChild(
                    child: const Icon(CupertinoIcons.time),
                    backgroundColor: Colors.green,
                    label: '14 Days',
                    labelStyle: const TextStyle(fontSize: 18.0),
                    onTap: () {
                      length = 14;
                      setState(() {});
                    }),
                SpeedDialChild(
                  child: const Icon(CupertinoIcons.time),
                  backgroundColor: Colors.yellow,
                  label: '7 Days',
                  labelStyle: const TextStyle(fontSize: 18.0),
                  onTap: () {
                    length = 7;
                    setState(() {});
                  },
                ),
                SpeedDialChild(
                  child: const Icon(CupertinoIcons.time),
                  backgroundColor: Colors.red,
                  label: '3 Days',
                  labelStyle: const TextStyle(fontSize: 18.0),
                  onTap: () {
                    length = 3;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}