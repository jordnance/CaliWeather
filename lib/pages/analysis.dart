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

  const Todo(
    this.rainData,
    this.tempData,
    this.humData,
    this.snowData,
  );
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

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    List<List<FlSpot>> data = await GraphHelper.newCoords();
    rain = data[0];
    temp = data[1];
    hum = data[2];
    snow = data[3];
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
                  child: Text("None"), // <-- TESTING
                );
              case ConnectionState.waiting:
                return const Center(
                  child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator()),
                );
              case ConnectionState.active:
                return const Center(child: Text("Active")); // <-- TESTING
              case ConnectionState.done:
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      const Center(
                        child: SizedBox(
                          height: 20,
                        ),
                      ),
                      RainGraph(todos: rain),
                      TempGraph(todos: temp),
                      HumGraph(todos: hum),
                      SnowGraph(todos: snow),
                      const Center(
                        child: SizedBox(
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                );
            }
          }),
    );
  }
}
