import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RadarPage extends StatefulWidget {
  const RadarPage({super.key, required this.title});
  final String title;

  @override
  State<RadarPage> createState() => _RadarPageState();
}

class _RadarPageState extends State<RadarPage> {
  double currentZoom = 5.6;
  double minZoom = 2.5;
  double maxZoom = 10;
  MapController mapController = MapController();
  LatLng currentCenter = LatLng(36.746842, -119.772586);

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
    currentCenter = LatLng(36.746842, -119.772586);
    mapController.move(currentCenter, currentZoom);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
            center: currentCenter,
            zoom: currentZoom,
            minZoom: minZoom,
            maxZoom: maxZoom,
            onPositionChanged: (MapPosition position, bool hasGesture) {
              currentCenter = position.center!;
              mapController.move(currentCenter, currentZoom);
            }),
        nonRotatedChildren: [
          AttributionWidget.defaultWidget(
            source: 'OpenStreetMap',
            onSourceTapped: null,
          ),
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          TileLayer(
            urlTemplate:
                'https://mesonet.agron.iastate.edu/cache/tile.py/1.0.0/nexrad-n0q-900913/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
            backgroundColor: Colors.transparent,
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 20,
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
            left: 20,
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
            left: 20,
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
