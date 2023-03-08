import 'package:geolocator/geolocator.dart';

class GeoHelper {
  static Future<bool> getPermissions() async {
    bool? serviceEnabled;
    LocationPermission? permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = false;
      return serviceEnabled;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        serviceEnabled = false;
        return serviceEnabled;
      }
    }
    serviceEnabled = true;
    return serviceEnabled;
  }
}
