import 'home.dart';
import 'radar.dart';
import 'analysis.dart';
import 'settings.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = '1pjvQXSwiEpbZJWtd73txBbtzvw0Bt5dZ2SpHGDx';
  const keyClientKey = 'YG5m7NvzYAYBtijV6LID0ygPaNXaFGDea5JZlZCH';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CaliWeather',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Main(title: 'CaliWeather'),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key, required this.title});
  final String title;
  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int _selectedIndex = 0;
  static List<Widget> pageOptions = <Widget>[
    const HomePage(title: 'Home Page',),
    const RadarPage(title: 'Radar Page',),
    const AnalysisPage(title: 'Analysis Page',),
    const SettingsPage(title: 'Settings Page',)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pageOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Color.fromARGB(255, 136, 136, 136)),
            BottomNavigationBarItem(
                icon: Icon(Icons.radar),
                label: 'Radar',
                backgroundColor: Color.fromARGB(255, 136, 136, 136)),
            BottomNavigationBarItem(
                icon: Icon(Icons.trending_up_rounded),
                label: 'Analysis',
                backgroundColor: Color.fromARGB(255, 136, 136, 136)),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
                backgroundColor: Color.fromARGB(255, 136, 136, 136)),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.yellow[600],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}
