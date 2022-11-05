import 'package:geolocator/geolocator.dart';

class FetchLocation {
  // Position position = Position(
  //   longitude: 0,
  //   latitude: 0,
  //   timestamp: DateTime.now(),
  //   accuracy: 0,
  //   altitude: 0,
  //   heading: 0,
  //   speed: 0,
  //   speedAccuracy: 0,
  // );

  static Future<Position> getCurrentLocation() async {

    Position position;
    
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await GeolocatorPlatform.instance.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await GeolocatorPlatform.instance.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await GeolocatorPlatform.instance.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await GeolocatorPlatform.instance.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    position = await GeolocatorPlatform.instance.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high));

    return position;
  }
}