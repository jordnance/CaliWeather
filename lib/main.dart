import 'util/userverify.dart';
import 'pages/home.dart';
import 'pages/radar.dart';
import 'pages/analysis.dart';
import 'pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'util/sharedprefutil.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefUtil.init();
  FMTCSettings setter = FMTCSettings(databaseMaxSize: 32);
  await FlutterMapTileCaching.initialise(settings: setter);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
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
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 2);

  List<Widget> _navBarPages() {
    return [
      const UserVerify(),
      const RadarPage(title: 'Radar Page'),
      const HomePage(title: 'Home Page'),
      const AnalysisPage(title: 'Analysis Page'),
      const SettingsPage(title: 'Settings Page'),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_2),
        title: ('Profile'),
        activeColorPrimary: const Color.fromARGB(255, 0, 83, 129),
        inactiveColorPrimary: const Color.fromARGB(255, 136, 136, 136),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.radar),
        title: ('Radar'),
        activeColorPrimary: const Color.fromARGB(255, 0, 83, 129),
        inactiveColorPrimary: const Color.fromARGB(255, 136, 136, 136),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ('Home'),
        activeColorPrimary: const Color.fromARGB(255, 0, 83, 129),
        inactiveColorPrimary: const Color.fromARGB(255, 136, 136, 136),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.trending_up_rounded),
        title: ('Analysis'),
        activeColorPrimary: const Color.fromARGB(255, 0, 83, 129),
        inactiveColorPrimary: const Color.fromARGB(255, 136, 136, 136),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: ('Settings'),
        activeColorPrimary: const Color.fromARGB(255, 0, 83, 129),
        inactiveColorPrimary: const Color.fromARGB(255, 136, 136, 136),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: _navBarPages(),
        items: _navBarItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        popAllScreensOnTapOfSelectedTab: true,
        navBarStyle: NavBarStyle.style9,
      ),
    );
  }
}
