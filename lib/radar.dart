import 'globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class RadarPage extends StatefulWidget {
  const RadarPage({super.key, required this.title});
  final String title;

  @override
  State<RadarPage> createState() => _RadarPageState();
}

class _RadarPageState extends State<RadarPage> {
  int index = 0;
  double minZoom = 3.5;
  double maxZoom = 10;
  double currentZoom = 5.5;
  MapController mapController = MapController();

  Position? currentPosition;
  LatLng currentCenter = LatLng(globals.positionLat, globals.positionLong);

  List<String> overlayUrl = [
    'https://mesonet.agron.iastate.edu/cache/tile.py/1.0.0/nexrad-n0q-900913/{z}/{x}/{y}.png',
    'https://tile.openweathermap.org/map/precipitation_new/{z}/{x}/{y}.png?appid=0d8187b327e042982d4478dcbf90bae3',
    'https://tile.openweathermap.org/map/temp_new/{z}/{x}/{y}.png?appid=0d8187b327e042982d4478dcbf90bae3',
    'https://tile.openweathermap.org/map/wind_new/{z}/{x}/{y}.png?appid=0d8187b327e042982d4478dcbf90bae3'
  ];

  List<String> overlayTitle = [
    'Radar',
    'Precipitation',
    'Temperature',
    'Wind Speed'
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
    if (index != 3) {
      index++;
    } else {
      index = 0;
    }
    setState(() {});
  }

  void moveMarker() {
    if (globals.positionLat != 36.746842 ||
        globals.positionLong != -119.772586) {
      setState(() {});
    }
  }

  getCurrentPosition() {
    Geolocator.requestPermission();
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsetsDirectional.only(bottom: 10),
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
                      urlTemplate: overlayUrl[index],
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
                overlayTitle[index],
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              backgroundColor: Colors.orange,
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
              backgroundColor: Colors.blue,
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
              backgroundColor: Colors.red,
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
              backgroundColor: Colors.green,
              tooltip: 'Zoom In',
              onPressed: zoomIn,
              child: const Icon(
                Icons.zoom_in_rounded,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
