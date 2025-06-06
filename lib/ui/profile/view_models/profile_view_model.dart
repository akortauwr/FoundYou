import 'package:flutter/material.dart';
import 'package:found_you_app/data/repositories/auth/auth_repository.dart';
import 'package:found_you_app/data/repositories/profile/profile_repository.dart';
import 'package:found_you_app/domain/models/user_model/user_model.dart';
import 'package:found_you_app/utils/result.dart';

class ProfileViewModel extends ChangeNotifier {
  final ProfileRepository _profileRepository;
  final AuthRepository _authRepository;
  UserModel? _userModel;
  bool _isLoading = false;

  ProfileViewModel({required ProfileRepository profileRepository, required AuthRepository authRepository})
      : _profileRepository = profileRepository,
        _authRepository = authRepository;

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

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    final result = await _authRepository.logout();
    if (result is Ok<void>) {
      // Successfully logged out, you might want to navigate to the login screen
      debugPrint('Successfully logged out');
    } else {
      // Handle error
      debugPrint('Error logging out: ${(result as Error).error}');
      // You can show a dialog or a snackbar with the error message
    }

    _isLoading = false;
    notifyListeners();
  }
}
