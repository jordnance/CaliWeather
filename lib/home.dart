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
        color: Colors.amber, // dynamic change needed
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Container(
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
            ),
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              child: Container(
                color: Colors.deepPurple, // debugging row height
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
