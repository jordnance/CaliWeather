import 'userverify.dart';
import 'home.dart';
import 'login.dart';
import 'profile.dart';
import 'radar.dart';
import 'analysis.dart';
import 'settings.dart';
import 'package:flutter/material.dart';
import 'package:caliweather/sharedprefutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefUtil.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CaliWeather',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Main(title: 'CaliWeather'),
        routes: {'/settings': (_) => const SettingsPage(title: 'Settings')});
  }
}

class Main extends StatefulWidget {
  const Main({super.key, required this.title});
  final String title;
  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int _selectedIndex = 1;
  static List<Widget> pageOptions = <Widget>[
    const UserVerify(),
    const HomePage(
      title: 'Home Page',
    ),
    const RadarPage(
      title: 'Radar Page',
    ),
    const AnalysisPage(
      title: 'Analysis Page',
    ),
    const SettingsPage(
      title: 'Settings Page',
    )
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
                icon: Icon(Icons.person_2),
                label: 'Profile',
                backgroundColor: Color.fromARGB(255, 136, 136, 136)),
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
