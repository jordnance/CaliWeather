import 'globals.dart' as globals;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeoHelper {
  static Future<void> getManualLocation(String city) async {
    List<Location> location = await locationFromAddress(city);
    globals.positionLat = location[0].latitude;
    globals.positionLong = location[0].longitude;
  }

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
