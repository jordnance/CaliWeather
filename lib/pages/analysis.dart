import 'package:flutter/material.dart';
import 'package:caliweather/pages/components/raingraph.dart';
import 'package:caliweather/pages/components/tempgraph.dart';
import 'package:caliweather/pages/components/humgraph.dart';
import 'package:caliweather/pages/components/snowgraph.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key, required this.title});
  final String title;

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SingleChildScrollView(
        child: Column(
          children: const <Widget>[
            Center(
              child: SizedBox(
                height: 20,
              ),
            ),
            RainGraph(),
            TempGraph(),
            HumGraph(),
            SnowGraph(),
            Center(
              child: SizedBox(
                height: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
