import 'package:flutter/material.dart';

class RadarPage extends StatefulWidget {
  const RadarPage({super.key, required this.title});
  final String title;
  
  @override
  State<RadarPage> createState() => _RadarPageState();
}

class _RadarPageState extends State<RadarPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
