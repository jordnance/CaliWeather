import 'package:flutter/material.dart';

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
                padding: EdgeInsets.all(10),
                color: Colors.deepPurple, // debugging row height
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Card(
                            child: Container(
                              width: 160.0,
                              color: Colors.red,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Cloudy"),
                                  Text("54"),
                                  Icon(Icons.ac_unit),
                                  Text("Jan 29"),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: Container(
                              width: 160.0,
                              color: Colors.red,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Cloudy"),
                                  Text("54"),
                                  Icon(Icons.ac_unit),
                                  Text("Jan 30"),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: Container(
                              width: 160.0,
                              color: Colors.red,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Cloudy"),
                                  Text("54"),
                                  Icon(Icons.ac_unit),
                                  Text("Jan 31"),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: Container(
                              width: 160.0,
                              color: Colors.red,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Cloudy"),
                                  Text("54"),
                                  Icon(Icons.ac_unit),
                                  Text("Feb 01"),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: Container(
                              width: 160.0,
                              color: Colors.red,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Cloudy"),
                                  Text("54"),
                                  Icon(Icons.ac_unit),
                                  Text("Feb 02"),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: Container(
                              width: 160.0,
                              color: Colors.red,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Cloudy"),
                                  Text("54"),
                                  Icon(Icons.ac_unit),
                                  Text("Feb 03"),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: Container(
                              width: 160.0,
                              color: Colors.red,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Cloudy"),
                                  Text("54"),
                                  Icon(Icons.ac_unit),
                                  Text("Feb 04"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
