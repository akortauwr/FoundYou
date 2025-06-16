import 'package:found_you_app/utils/result.dart';
import 'package:geolocator/geolocator.dart';

class LocationException implements Exception {
  final String message;

  LocationException(this.message);

  @override
  String toString() => message;
}

class LocationService {
  Future<Result<Position>> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Error(LocationException("Usługi lokalizacyjne są wyłączone."));
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Error(LocationException("Odmówiono uprawnień do lokalizacji."));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Error(
        LocationException("Uprawnienia do lokalizacji są zablokowane na stałe. Zmień je w ustawieniach aplikacji."),
      );
    }

    try {
      const locationSettings = LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 0);

      final position = await Geolocator.getPositionStream(locationSettings: locationSettings).first;

      return Ok(position);
    } catch (e) {
      return Error(LocationException("Nie udało się pobrać lokalizacji: $e"));
    }
  }
}
