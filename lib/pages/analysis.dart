import '../util/sharedprefutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:caliweather/util/graph_helper.dart';
import 'package:caliweather/pages/components/raingraph.dart';
import 'package:caliweather/pages/components/tempgraph.dart';
import 'package:caliweather/pages/components/humgraph.dart';
import 'package:caliweather/pages/components/snowgraph.dart';
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

const List<Widget> weathericons = <Widget>[
  Icon(CupertinoIcons.thermometer),
  Icon(CupertinoIcons.cloud_rain),
  Icon(CupertinoIcons.wind),
  Icon(CupertinoIcons.snow),
  Icon(CupertinoIcons.drop),
  Icon(CupertinoIcons.gauge),
];

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key, required this.title});
  final String title;

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  final List<bool> weatherSelected = [true, false, false, false, false, false];
  bool isTempVisible = true;
  bool isHumVisible = false;
  bool isPressVisible = false;
  bool isWindVisible = false;
  bool isRainVisible = false;
  bool isSnowVisible = false;

  List<FlSpot>? rain;
  List<FlSpot>? temp;
  List<FlSpot>? hum;
  List<FlSpot>? snow;
  List<FlSpot>? wind;
  List<FlSpot>? press;
  double? length;
  Color pgBackgroundColor = Colors.grey.shade200;

  Future<void> getData() async {
    if (SharedPrefUtil.getIsLoggedIn()) {
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: pgBackgroundColor,
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
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const Center(
                          child: SizedBox(
                            height: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                          child: ToggleButtons(
                            onPressed: (int index) {
                              int count = 0;
                              for (final bool value in weatherSelected) {
                                if (value) {
                                  count += 1;
                                }
                              }
                              if (weatherSelected[index] && count < 2) {
                                return;
                              }
                              setState(() {
                                weatherSelected[index] =
                                    !weatherSelected[index];
                                if (index == 0 && weatherSelected[index]) {
                                  isTempVisible = true;
                                } else if (index == 0 &&
                                    !weatherSelected[index]) {
                                  isTempVisible = false;
                                }
                                if (index == 1 && weatherSelected[index]) {
                                  isRainVisible = true;
                                } else if (index == 1 &&
                                    !weatherSelected[index]) {
                                  isRainVisible = false;
                                }
                                if (index == 2 && weatherSelected[index]) {
                                  isWindVisible = true;
                                } else if (index == 2 &&
                                    !weatherSelected[index]) {
                                  isWindVisible = false;
                                }
                                if (index == 3 && weatherSelected[index]) {
                                  isSnowVisible = true;
                                } else if (index == 3 &&
                                    !weatherSelected[index]) {
                                  isSnowVisible = false;
                                }
                                if (index == 4 && weatherSelected[index]) {
                                  isHumVisible = true;
                                } else if (index == 4 &&
                                    !weatherSelected[index]) {
                                  isHumVisible = false;
                                }
                                if (index == 5 && weatherSelected[index]) {
                                  isPressVisible = true;
                                } else if (index == 5 &&
                                    !weatherSelected[index]) {
                                  isPressVisible = false;
                                }
                              });
                            },
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            selectedBorderColor: Colors.blue,
                            borderColor: const Color.fromARGB(255, 71, 87, 99),
                            borderWidth: 2.2,
                            selectedColor: Colors.white,
                            fillColor: const Color.fromARGB(255, 32, 73, 103),
                            color: Colors.grey.shade700,
                            constraints: const BoxConstraints(
                                minHeight: 60.0, minWidth: 55.0),
                            isSelected: weatherSelected,
                            children: weathericons,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                          child: Divider(
                            thickness: 2.8,
                            color: Color(0xff37434d),
                          ),
                        ),
                        Visibility(
                          visible: isTempVisible,
                          child: Column(
                            children: [
                              TempGraph(todos: temp, duration: length)
                            ],
                          ),
                        ),
                        Visibility(
                          visible: isRainVisible,
                          child: Column(
                            children: [
                              RainGraph(todos: rain, duration: length),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: isWindVisible,
                          child: Column(
                            children: [
                              WindGraph(todos: wind, duration: length)
                            ],
                          ),
                        ),
                        Visibility(
                          visible: isSnowVisible,
                          child: Column(
                            children: [
                              SnowGraph(todos: snow, duration: length)
                            ],
                          ),
                        ),
                        Visibility(
                          visible: isHumVisible,
                          child: Column(
                            children: [HumGraph(todos: hum, duration: length)],
                          ),
                        ),
                        Visibility(
                          visible: isPressVisible,
                          child: Column(
                            children: [
                              PressGraph(todos: press, duration: length)
                            ],
                          ),
                        ),
                        const Center(
                          child: SizedBox(
                            height: 60,
                          ),
                        ),
                      ],
                    ),
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
                backgroundColor: const Color.fromARGB(255, 255, 177, 81),
                tooltip: 'Refresh',
                onPressed: () {
                  setState(() {});
                },
                child: const Icon(
                  Icons.refresh_rounded,
                  size: 35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
