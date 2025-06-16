import 'package:flutter/material.dart';
import 'package:found_you_app/data/repositories/profile/profile_repository.dart';
import 'package:found_you_app/data/services/location/location_service.dart';
import 'package:found_you_app/ui/near_you/view_models/near_you_view_model.dart';
import 'package:found_you_app/ui/new_matches/view_models/new_matches_view_model.dart';
import 'package:found_you_app/ui/recent_likes/view_models/recent_likes_view_model.dart';
import 'package:found_you_app/utils/result.dart';
import 'package:geolocator/geolocator.dart';

class HomeViewModel extends ChangeNotifier {
  final NewMatchesViewModel newMatchesVM;
  final RecentLikesViewModel recentLikesVM;
  final NearYouViewModel nearYouVM;

  final ProfileRepository _profileRepository;
  final LocationService _locationService;

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  HomeViewModel({
    required this.newMatchesVM,
    required this.recentLikesVM,
    required this.nearYouVM,
    required ProfileRepository profileRepository,
    required LocationService locationService,
  }) : _profileRepository = profileRepository,
       _locationService = locationService;

  Future<void> init() async {
    try {
      _updateLocation();

      await Future.wait([
        newMatchesVM.fetchSuggestedFriends(),
        recentLikesVM.fetchSuggestedFriends(),
        nearYouVM.fetchSuggestedFriends(),
      ]);
    } catch (e) {
      debugPrint('Błąd podczas inicjalizacji HomeViewModel: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _updateLocation() async {
    final locationResult = await _locationService.getCurrentLocation();

    switch (locationResult) {
      case Ok<Position> ok:
        final position = ok.value;
        debugPrint('Pobrano lokalizację: Lat: ${position.latitude}, Lng: ${position.longitude}');
        final updateResult = await _profileRepository.updateLocation(
          latitude: position.latitude,
          longitude: position.longitude,
        );
        if (updateResult is Error) {
          debugPrint('Błąd wysyłania lokalizacji na serwer: ${updateResult.error}');
        } else {
          debugPrint('Lokalizacja pomyślnie zaktualizowana na serwerze.');
        }
        break;
      case Error error:
        debugPrint('Błąd pobierania lokalizacji: ${error.error}');
        break;
    }
  }
}
