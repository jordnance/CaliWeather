import 'package:geolocator/geolocator.dart';
import 'package:caliweather/util/sharedprefutil.dart';

class GeoHelper {
  static Future<bool> getPermissions() async {
    bool? serviceEnabled;
    LocationPermission? permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      SharedPrefUtil.setServiceEnabled(serviceEnabled);
      return serviceEnabled;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        serviceEnabled = false;
        SharedPrefUtil.setServiceEnabled(serviceEnabled);
        return serviceEnabled;
      }
    }
    
    SharedPrefUtil.setServiceEnabled(serviceEnabled);
    return serviceEnabled;
  }
}
