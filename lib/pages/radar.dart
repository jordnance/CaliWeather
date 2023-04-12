import 'dart:async';
import 'package:caliweather/util/sharedprefutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:caliweather/util/radar_util.dart';
import 'package:caliweather/util/geo_helper.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';

class RadarPage extends StatefulWidget {
  const RadarPage({super.key, required this.title});
  final String title;

  @override
  State<RadarPage> createState() => _RadarPageState();
}

class _RadarPageState extends State<RadarPage> {
  int overlayIndex = 0;
  int playStopIndex = 0;
  double radarIndex = 4;
  double minZoom = 3.5;
  double maxZoom = 10;
  double currentZoom = 5.5;
  double currentSliderValue = -2;
  MapController mapController = MapController();

  bool timerCancel = false;
  late Timer timerClearCache;
  Position? currentPosition;
  final store = FlutterMapTileCaching.instance('RadarStore');
  LatLng currentCenter =
      LatLng(SharedPrefUtil.getLatitude(), SharedPrefUtil.getLongitude());

  List<String> pastRadarUrl = [
    'https://tilecache.rainviewer.com/v2/radar/${RadarUtil.getTimestamps(0)}/512/{z}/{x}/{y}/1/1_1.png',
    'https://tilecache.rainviewer.com/v2/radar/${RadarUtil.getTimestamps(1)}/512/{z}/{x}/{y}/1/1_1.png',
    'https://tilecache.rainviewer.com/v2/radar/${RadarUtil.getTimestamps(2)}/512/{z}/{x}/{y}/1/1_1.png',
    'https://tilecache.rainviewer.com/v2/radar/${RadarUtil.getTimestamps(3)}/512/{z}/{x}/{y}/1/1_1.png',
    'https://tilecache.rainviewer.com/v2/radar/${RadarUtil.getTimestamps(4)}/512/{z}/{x}/{y}/1/1_1.png',
  ];

  List<String> overlayUrl = [
    'https://imgflip.com/s/meme/Blank-Transparent-Square.png',
    'https://tile.openweathermap.org/map/clouds_new/{z}/{x}/{y}.png?appid=0d8187b327e042982d4478dcbf90bae3',
    'https://tile.openweathermap.org/map/temp_new/{z}/{x}/{y}.png?appid=0d8187b327e042982d4478dcbf90bae3',
    'https://tile.openweathermap.org/map/wind_new/{z}/{x}/{y}.png?appid=0d8187b327e042982d4478dcbf90bae3'
  ];

  List<String> overlayTitle = ['None', 'Clouds', 'Temps', 'Wind'];
  List<IconData> playStop = [Icons.play_arrow_rounded, Icons.stop_rounded];

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
    store.manage.create();
    clearCache();
  }

  @override
  void dispose() {
    timerCancel = true;
    super.dispose();
  }

  void zoomOut() {
    if (currentZoom > minZoom) {
      currentZoom = currentZoom - .5;
      mapController.move(currentCenter, currentZoom);
    }
  }

  void zoomIn() {
    if (currentZoom < maxZoom) {
      currentZoom = currentZoom + .5;
      mapController.move(currentCenter, currentZoom);
    }
  }

  void centerBack() {
    moveMarker();
    if (currentPosition != null) {
      SharedPrefUtil.setLatitude(currentPosition!.latitude);
      SharedPrefUtil.setLongitude(currentPosition!.longitude);
      currentCenter =
          LatLng(SharedPrefUtil.getLatitude(), SharedPrefUtil.getLongitude());
      mapController.move(currentCenter, currentZoom);
    } else {
      currentCenter =
          LatLng(SharedPrefUtil.getLatitude(), SharedPrefUtil.getLongitude());
      mapController.move(currentCenter, currentZoom);
    }
  }

  void changeOverlays() {
    if (overlayIndex != 3) {
      overlayIndex++;
    } else {
      overlayIndex = 0;
    }
    currentSliderValue = -2;
    radarIndex = 4;
    setState(() {});
  }

  void changeRadar(double value) {
    radarIndex = value * -2;
    setState(() {});
  }

  void moveMarker() {
    setState(() {});
  }

  void changeIcon() {
    if (playStopIndex == 0) {
      playStopIndex++;
      currentSliderValue = -2;
      radarIndex = 4;
    } else {
      playStopIndex = 0;
    }
    setState(() {});
  }

  void play() {
    changeIcon();
    if (playStopIndex == 1) {
      Timer.periodic(const Duration(milliseconds: 1500), (timer) {
        if (currentSliderValue == 0 || radarIndex == 0) {
          changeIcon();
          timer.cancel();
        } else if (playStopIndex == 0) {
          timer.cancel();
        } else {
          currentSliderValue += 0.5;
          radarIndex--;
          setState(() {});
        }
      });
    } else {
      currentSliderValue = -2;
      radarIndex = 4;
      setState(() {});
    }
  }

  void clearCache() {
    Timer.periodic(const Duration(minutes: 10), (timer) {
      store.manage.reset();
      if (timerCancel) {
        timer.cancel();
      }
    });
  }

  void getCurrentPosition() async {
    var serviceEnabled = await GeoHelper.getPermissions();
    if (serviceEnabled) {
      SharedPrefUtil.setServiceEnabled(true);
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        setState(() {
          currentPosition = position;
          SharedPrefUtil.setLatitude(position.latitude);
          SharedPrefUtil.setLongitude(position.longitude);
          centerBack();
        });
      });
    } else if (SharedPrefUtil.getIsLoggedIn()) {
      SharedPrefUtil.setServiceEnabled(false);
      centerBack();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsetsDirectional.only(bottom: 10),
            child: Column(
              children: [
                Flexible(
                  child: FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                        center: currentCenter,
                        zoom: currentZoom,
                        minZoom: minZoom,
                        maxZoom: maxZoom,
                        interactiveFlags:
                            InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                        maxBounds: LatLngBounds(
                          LatLng(63.00, -148.00),
                          LatLng(3.200, -95.75),
                        ),
                        onPositionChanged:
                            (MapPosition position, bool hasGesture) {
                          currentCenter = position.center!;
                          mapController.move(currentCenter, currentZoom);
                        }),
                    nonRotatedChildren: [
                      AttributionWidget.defaultWidget(
                        source: 'OpenStreetMap',
                        onSourceTapped: null,
                        alignment: Alignment.bottomLeft,
                      ),
                    ],
                    children: [
                      TileLayer(
                        tileProvider:
                            FMTC.instance('RadarStore').getTileProvider(),
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      TileLayer(
                        tileProvider:
                            FMTC.instance('RadarStore').getTileProvider(),
                        urlTemplate: overlayUrl[overlayIndex],
                        userAgentPackageName: 'com.example.app',
                        backgroundColor: Colors.transparent,
                      ),
                      TileLayer(
                        tileProvider:
                            FMTC.instance('RadarStore').getTileProvider(),
                        urlTemplate: pastRadarUrl[radarIndex.round()],
                        userAgentPackageName: 'com.example.app',
                        backgroundColor: Colors.transparent,
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                              point: LatLng(SharedPrefUtil.getLatitude(),
                                  SharedPrefUtil.getLongitude()),
                              width: 80,
                              height: 80,
                              builder: (context) => const Icon(Icons.location_on,
                                  color: Colors.deepPurple, size: 45)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              left: 10,
              bottom: 30,
              child: FloatingActionButton.extended(
                label: Text(
                  overlayTitle[overlayIndex],
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                backgroundColor: const Color.fromARGB(255, 255, 177, 81),
                tooltip: 'Overlays',
                onPressed: changeOverlays,
                icon: const Icon(
                  Icons.layers,
                  size: 40,
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 150,
              child: FloatingActionButton(
                backgroundColor: const Color.fromARGB(255, 114, 154, 255),
                tooltip: 'Center',
                onPressed: centerBack,
                child: const Icon(
                  Icons.my_location_rounded,
                  size: 30,
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 80,
              child: FloatingActionButton(
                backgroundColor: const Color.fromARGB(255, 182, 68, 48),
                tooltip: 'Zoom Out',
                onPressed: zoomOut,
                child: const Icon(
                  Icons.zoom_out_rounded,
                  size: 40,
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: FloatingActionButton(
                backgroundColor: const Color.fromARGB(255, 174, 172, 87),
                tooltip: 'Zoom In',
                onPressed: zoomIn,
                child: const Icon(
                  Icons.zoom_in_rounded,
                  size: 40,
                ),
              ),
            ),
            Positioned(
              right: 12,
              bottom: 222,
              child: RotatedBox(
                quarterTurns: 3,
                child: Container(
                  width: 265,
                  height: 53,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 56, 122, 170),
                      borderRadius: BorderRadius.circular(26)),
                  child: Center(
                    child: Row(
                      children: [
                        const SizedBox(width: 5),
                        RotatedBox(
                          quarterTurns: 1,
                          child: FloatingActionButton(
                            backgroundColor: Colors.transparent,
                            onPressed: play,
                            elevation: 0,
                            child: Icon(
                              playStop[playStopIndex],
                              size: 40,
                              color: const Color.fromARGB(255, 255, 177, 81),
                            ),
                          ),
                        ),
                        Slider(
                          divisions: 4,
                          value: currentSliderValue,
                          min: -2,
                          max: 0,
                          activeColor: const Color.fromARGB(255, 125, 197, 255),
                          inactiveColor: Colors.white,
                          thumbColor: const Color.fromARGB(255, 255, 177, 81),
                          onChanged: (double value) {
                            setState(() {
                              currentSliderValue = value;
                              changeRadar(currentSliderValue);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
