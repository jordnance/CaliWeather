import 'globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:caliweather/util/radar_util.dart';
import 'package:caliweather/geo_helper.dart';

import 'package:caliweather/sharedprefutil.dart';

class RadarPage extends StatefulWidget {
  const RadarPage({super.key, required this.title});
  final String title;

  @override
  State<RadarPage> createState() => _RadarPageState();
}

class _RadarPageState extends State<RadarPage> {
  int overlayIndex = 0;
  double radarIndex = 0;
  double minZoom = 3.5;
  double maxZoom = 10;
  double currentZoom = 5.5;
  double currentSliderValue = 0;
  MapController mapController = MapController();

  Position? currentPosition;
  LatLng currentCenter = LatLng(globals.positionLat, globals.positionLong);

  List<String> pastRadarUrl = [
    'https://tilecache.rainviewer.com/v2/radar/${RadarUtil.getTimestamps(0)}/512/{z}/{x}/{y}/1/1_1.png',
    'https://tilecache.rainviewer.com/v2/radar/${RadarUtil.getTimestamps(1)}/512/{z}/{x}/{y}/1/1_1.png',
    'https://tilecache.rainviewer.com/v2/radar/${RadarUtil.getTimestamps(2)}/512/{z}/{x}/{y}/1/1_1.png',
    'https://tilecache.rainviewer.com/v2/radar/${RadarUtil.getTimestamps(3)}/512/{z}/{x}/{y}/1/1_1.png',
    'https://tilecache.rainviewer.com/v2/radar/${RadarUtil.getTimestamps(4)}/512/{z}/{x}/{y}/1/1_1.png',
  ];

  List<String> overlayUrl = [
    'https://tile.openweathermap.org/map/clouds_new/{z}/{x}/{y}.png?appid=0d8187b327e042982d4478dcbf90bae3',
    'https://tile.openweathermap.org/map/temp_new/{z}/{x}/{y}.png?appid=0d8187b327e042982d4478dcbf90bae3',
    'https://tile.openweathermap.org/map/wind_new/{z}/{x}/{y}.png?appid=0d8187b327e042982d4478dcbf90bae3'
  ];

  List<String> overlayTitle = [
    'Clouds',
    'Temps',
    'Wind'
  ];

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
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
      globals.positionLat = currentPosition!.latitude;
      globals.positionLong = currentPosition!.longitude;
      currentCenter = LatLng(globals.positionLat, globals.positionLong);
      mapController.move(currentCenter, currentZoom);
    } else {
      currentCenter = LatLng(globals.positionLat, globals.positionLong);
      mapController.move(currentCenter, currentZoom);
    }
  }

  void changeOverlays() {
    if (overlayIndex != 2) {
      overlayIndex++;
    } else {
      overlayIndex = 0;
    }
    setState(() {});
  }

  void changeRadar(double value) {
    radarIndex = value * 2;
    setState(() {});
  }

  void moveMarker() {
    setState(() {});
  }

  void getCurrentPosition() async {
    var serviceEnabled = await GeoHelper.getPermissions();
    if (serviceEnabled) {
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        setState(() {
          currentPosition = position;
        });
      });
    } else {
      var location = SharedPrefUtil.getLocation();
      GeoHelper.getManualLocation(location);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
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
                      tileProvider: NetworkTileProvider(),
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    TileLayer(
                      tileProvider: NetworkTileProvider(),
                      urlTemplate: overlayUrl[overlayIndex],
                      userAgentPackageName: 'com.example.app',
                      backgroundColor: Colors.transparent,
                    ),
                    TileLayer(
                      tileProvider: NetworkTileProvider(),
                      urlTemplate: pastRadarUrl[radarIndex.round()],
                      userAgentPackageName: 'com.example.app',
                      backgroundColor: Colors.transparent,
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                            point: LatLng(
                                globals.positionLat, globals.positionLong),
                            width: 80,
                            height: 80,
                            builder: (context) => Container(
                                  child: const Icon(Icons.location_on,
                                      color: Colors.deepPurple, size: 45),
                                )),
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
            bottom: 20,
            child: FloatingActionButton.extended(
              label: Text(
                overlayTitle[overlayIndex],
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              backgroundColor: Color.fromARGB(255, 255, 177, 81),
              tooltip: 'Overlays',
              onPressed: changeOverlays,
              icon: const Icon(
                Icons.layers,
                size: 40,
              ),
            ),
          ),
          Positioned(
            right: 15,
            bottom: 155,
            child: FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 114, 154, 255),
              tooltip: 'Center',
              onPressed: centerBack,
              child: const Icon(
                Icons.my_location_rounded,
                size: 30,
              ),
            ),
          ),
          Positioned(
            right: 15,
            bottom: 80,
            child: FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 182, 68, 48),
              tooltip: 'Zoom Out',
              onPressed: zoomOut,
              child: const Icon(
                Icons.zoom_out_rounded,
                size: 40,
              ),
            ),
          ),
          Positioned(
            right: 15,
            bottom: 5,
            child: FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 174, 172, 87),
              tooltip: 'Zoom In',
              onPressed: zoomIn,
              child: const Icon(
                Icons.zoom_in_rounded,
                size: 40,
              ),
            ),
          ),
          Positioned(
            right: 19,
            bottom: 230,
            child: RotatedBox(
              quarterTurns: 3,
              child: Container(
                width: 267,
                height: 55,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 220, 220, 220),
                    border: Border.all(
                        width: 4, color: Colors.black),
                    borderRadius: BorderRadius.circular(28)),
                child: Center(
                  child: Row(
                    children: [
                      const SizedBox(width: 15),
                      const RotatedBox(
                        quarterTurns: 1,
                        child: Text(
                          'Now',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                      Slider(
                        divisions: 4,
                        value: currentSliderValue,
                        min: 0,
                        max: 2,
                        label: '$currentSliderValue',
                        onChanged: (double value) {
                          setState(() {
                            currentSliderValue = value;
                            changeRadar(currentSliderValue);
                          });
                        },
                        // ),
                      ),
                      const RotatedBox(
                        quarterTurns: 1,
                        child: Text(
                          '-2 hr',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
