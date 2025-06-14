import 'package:flutter/material.dart';
import 'package:found_you_app/data/repositories/profile/profile_repository.dart';
import 'package:found_you_app/utils/result.dart';

class ResetPasswordViewModel extends ChangeNotifier {
  final ProfileRepository _repository;

  ResetPasswordViewModel({required ProfileRepository repository}) : _repository = repository;

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  bool _resetError = false;

  bool get resetError => _resetError;

  void reset() {
    _resetError = false;
    notifyListeners();

    final oldPassword = oldPasswordController.text;
    final newPassword = newPasswordController.text;
    final confirmNewPassword = confirmNewPasswordController.text;

    if (newPassword != confirmNewPassword) {
      _resetError = true;
      notifyListeners();
      return;
    }

    _repository.resetPassword(oldPassword: oldPassword, newPassword: newPassword).then((result) {
      if (result is Error<void>) {
        _resetError = true;
      }
      notifyListeners();
    });
  }
}
