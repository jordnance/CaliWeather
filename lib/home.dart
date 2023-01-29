import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: Column(
          children: <Widget>[
            //Expanded(
            Container(
              constraints: BoxConstraints(
                  minHeight: 200,
                  maxHeight: MediaQuery.of(context).size.height),
              color: Colors.blue, // debugging row height
              child: Row(
                children: const <Widget>[
                  Expanded(
                    child: Text(
                      'Bakersfield',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ],
              ),
            ),
            //),
            Expanded(
              child: Container(
                color: Colors.pink, // debugging row height
                child: Row(
                  children: const <Widget>[
                    Expanded(
                      child: Icon(
                        Icons.ac_unit,
                      ),
                    ),
                    Expanded(
                      child: Text('65', textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.deepPurple,
                child: Row(
                  children: const <Widget>[
                    Expanded(
                      child: Text('Carousel PaceHolder',
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
