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
      debugPrint('Error loading profile: ${(result as Error).error}');

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
      debugPrint('Successfully logged out');
    } else {
      debugPrint('Error logging out: ${(result as Error).error}');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteAccount() async {
    final result = await _profileRepository.deleteProfile();
    if (result is Ok<void>) {
      debugPrint('Successfully deleted account');
      await logout();
    } else {
      debugPrint('Error deleting account: ${(result as Error).error}');
    }
  }
}
