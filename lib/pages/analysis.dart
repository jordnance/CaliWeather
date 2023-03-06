import '../util/sharedprefutil.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:caliweather/util/graph_helper.dart';
import 'package:caliweather/pages/components/raingraph.dart';
import 'package:caliweather/pages/components/tempgraph.dart';
import 'package:caliweather/pages/components/humgraph.dart';
import 'package:caliweather/pages/components/snowgraph.dart';

class Todo {
  final String rainData;
  final String tempData;
  final String humData;
  final String snowData;
  final String duration;

  const Todo(
      this.rainData, this.tempData, this.humData, this.snowData, this.duration);
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
  double? length = 14;
  bool? isPressed = false;
  int durationIndex = 1;

  Future<void> getData() async {
    if (SharedPrefUtil.getIsLoggedIn() == true) {
      List<List<FlSpot>> data = await GraphHelper.newCoords();
      rain = data[0];
      temp = data[1];
      hum = data[2];
      snow = data[3];
    }
  }

  @override
  Widget build(BuildContext context) {
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
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      const Center(
                        child: SizedBox(
                          height: 20,
                        ),
                      ),
                      RainGraph(todos: rain, duration: length),
                      TempGraph(todos: temp, duration: length),
                      HumGraph(todos: hum, duration: length),
                      SnowGraph(todos: snow, duration: length),
                      const Center(
                        child: SizedBox(
                          height: 70,
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
              backgroundColor: Colors.blue,
              tooltip: 'Duration',
              onPressed: () {
                //if (isPressed == false) {
                //  length = 7;
                //  isPressed = true;
                //} else {
                //  length = 14;
                //  isPressed = false;
                //}

                if (durationIndex == 3) {
                  durationIndex = 1;
                } else {
                  durationIndex++;
                }

                switch (durationIndex) {
                  case 1:
                    length = 14;
                    break;
                  case 2:
                    length = 7;
                    break;
                  case 3:
                    length = 3;
                    break;
                }

                setState(() {});
              },
              child: const Icon(
                Icons.timelapse_rounded,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
