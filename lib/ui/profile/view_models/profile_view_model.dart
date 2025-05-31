import 'package:flutter/material.dart';
import 'package:found_you_app/data/repositories/profile/profile_repository.dart';
import 'package:found_you_app/domain/models/user_model/user_model.dart';
import 'package:found_you_app/utils/result.dart';

class ProfileViewModel extends ChangeNotifier {
  final ProfileRepository _profileRepository;
  UserModel? _userModel;
  bool _isLoading = false;

  ProfileViewModel({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository;

  UserModel? get userModel => _userModel;
  bool get isLoading => _isLoading;

  Future<void> loadProfile() async {
    _isLoading = true;
    notifyListeners();

    final result = await _profileRepository.loadProfile();
    if (result is Ok<UserModel>) {
      _userModel = result.value;
    } else {
      // Handle error
      debugPrint('Error loading profile: ${(result as Error).error}');
      // You can show a dialog or a snackbar with the error message
      // For example:

      debugPrintStack(label: 'Error loading profile', stackTrace: StackTrace.current);
    }

    _isLoading = false;
    notifyListeners();
  }
}
