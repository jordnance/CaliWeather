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

const List<Widget> weathericons = <Widget>[
  Icon(Icons.device_thermostat_sharp),
  Icon(Icons.water_drop_sharp),
  Icon(Icons.air_sharp),
  Icon(Icons.ac_unit_sharp),
  Icon(Icons.waves_sharp),
  Icon(Icons.sync_alt_sharp),
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
  double? length = 14;
  bool? isPressed = false;
  int durationIndex = 1;
  int titleIndex = 0;
  Color pgBackgroundColor = Colors.grey.shade200;

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

    // Graph dummy data for testing
    else {
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

      List<FlSpot> tempData = [];
      for (int i = 0; i < durationLength! + 1; i++) {
        tempData.insert(i, dummyRain[i]);
      }
      rain = tempData;
      tempData = [];

      for (int i = 0; i < durationLength + 1; i++) {
        tempData.insert(i, dummyTemp[i]);
      }
      temp = tempData;
      tempData = [];

      for (int i = 0; i < durationLength + 1; i++) {
        tempData.insert(i, dummyHum[i]);
      }
      hum = tempData;
      tempData = [];

      for (int i = 0; i < durationLength + 1; i++) {
        tempData.insert(i, dummySnow[i]);
      }
      snow = tempData;
      tempData = [];

      for (int i = 0; i < durationLength + 1; i++) {
        tempData.insert(i, dummyWind[i]);
      }
      wind = tempData;
      tempData = [];

      for (int i = 0; i < durationLength + 1; i++) {
        tempData.insert(i, dummyPress[i]);
      }
      press = tempData;
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
                return SingleChildScrollView(
                  child: Column(
                  children: <Widget>[
                    const Center(
                      child: SizedBox(
                        height: 50,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15,0,15,20),
                      child: ToggleButtons(
                        onPressed:(int index) {
                          int count = 0;
                          for (final bool value in weatherSelected){
                            if(value){
                              count += 1;
                            }
                          }
                          if(weatherSelected[index] && count < 2){
                            return;
                          }
                          setState(() {
                            weatherSelected[index] = !weatherSelected[index];
                            if(index==0 && weatherSelected[index]){
                              isTempVisible = true; 
                            }
                            else if(index==0 && !weatherSelected[index]){
                              isTempVisible = false;
                            }
                            if(index==1 && weatherSelected[index]){
                              isRainVisible = true;
                            }
                            else if(index==1 && !weatherSelected[index]){
                              isRainVisible = false;
                            }
                            if(index==2 && weatherSelected[index]){
                              isWindVisible = true;
                            }
                            else if(index==2 && !weatherSelected[index]){
                              isWindVisible = false;
                            }
                            if(index==3 && weatherSelected[index]){
                              isSnowVisible = true;
                            }
                            else if(index==3 && !weatherSelected[index]){
                              isSnowVisible = false;
                            }
                            if(index==4 && weatherSelected[index]){
                              isHumVisible = true;
                            }
                            else if(index==4 && !weatherSelected[index]){
                              isHumVisible = false;
                            }
                            if(index==5 && weatherSelected[index]){
                              isPressVisible = true;
                            }
                            else if(index==5 && !weatherSelected[index]){
                              isPressVisible = false;
                            }
                          });
                        },
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        selectedBorderColor: const Color(0xff37434d),
                        borderColor: const Color.fromARGB(255, 71, 87, 99),
                        borderWidth: 1.8,
                        selectedColor: Colors.white,
                        fillColor: const Color(0xff37434d),
                        color: const Color.fromARGB(255, 188, 179, 179),
                        constraints: const BoxConstraints(
                          minHeight: 70.0, 
                          minWidth: 55.0
                        ),
                        isSelected: weatherSelected,
                        children: weathericons,  
                      ),
                    ),
                    
                    const Padding(
                        padding: EdgeInsets.fromLTRB(20,10,20,5),
                        child: 
                        Divider(
                          thickness: 2,
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
                          children: [
                            HumGraph(todos: hum, duration: length)
                          ],
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
                   
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20,10,20,10),
                        child: Divider(
                          thickness: 2,
                          color: Color(0xff37434d),
                        ),
                      ),

                      const Center(
                        child: SizedBox(
                          height: 75,
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
