import 'package:flutter/material.dart';
import 'package:found_you_app/data/repositories/auth/auth_repository.dart';
import 'package:found_you_app/utils/result.dart';

class ResetPasswordViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  ResetPasswordViewModel({required AuthRepository authRepository}) : _authRepository = authRepository;

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

    _authRepository.resetPassword(oldPassword: oldPassword, newPassword: newPassword).then((result) {
      if (result is Error<void>) {
        _resetError = true;
      }
      notifyListeners();
    });
  }
}
