import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

class RadarPage extends StatefulWidget {
  const RadarPage({super.key, required this.title});
  final String title;

  @override
  State<RadarPage> createState() => _RadarPageState();
}

class _RadarPageState extends State<RadarPage> {
  int index = 0;
  double currentZoom = 5.5;
  double minZoom = 3.5;
  double maxZoom = 10;
  MapController mapController = MapController();
  LatLng currentCenter = LatLng(36.746842, -119.772586);
  List<String> overlays = [
    'https://mesonet.agron.iastate.edu/cache/tile.py/1.0.0/nexrad-n0q-900913/{z}/{x}/{y}.png',
    'https://tile.openweathermap.org/map/precipitation_new/{z}/{x}/{y}.png?appid=0d8187b327e042982d4478dcbf90bae3',
    'https://tile.openweathermap.org/map/temp_new/{z}/{x}/{y}.png?appid=0d8187b327e042982d4478dcbf90bae3',
    'https://tile.openweathermap.org/map/wind_new/{z}/{x}/{y}.png?appid=0d8187b327e042982d4478dcbf90bae3'
  ];

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
    // Centers map back to Fresno (best place to get entire view of CA)
    // This will be updated later to center on user's selected location
    // once the Settings Page is functional
    currentCenter = LatLng(36.746842, -119.772586);
    mapController.move(currentCenter, currentZoom);
  }

  void changeOverlays() {
    if (index != 3) {
      index++;
    } else {
      index = 0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
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
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    TileLayer(
                      tileProvider: NetworkTileProvider(),
                      urlTemplate: overlays[index],
                      userAgentPackageName: 'com.example.app',
                      backgroundColor: Colors.transparent,
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                            // Will be updated to the user's set location in the future
                            point: LatLng(36.746842, -119.772586),
                            width: 80,
                            height: 80,
                            builder: (context) => Container(
                                  child: const Icon(Icons.location_on,
                                      color: Colors.red, size: 45),
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
            left: 15,
            bottom: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.orange,
              tooltip: 'Overlays',
              onPressed: changeOverlays,
              child: const Icon(
                Icons.layers,
                size: 45,
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
                size: 45,
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
                size: 45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
