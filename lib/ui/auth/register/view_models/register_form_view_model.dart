import 'package:flutter/material.dart';
import 'package:found_you_app/data/repositories/auth/auth_repository.dart';
import 'package:found_you_app/domain/models/form_field/form_field_model.dart';
import 'package:found_you_app/utils/result.dart';

class RegisterFormViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  RegisterFormViewModel({required AuthRepository authRepository}) : _authRepository = authRepository;

  List<FormFieldModel>? _fields;

  List<FormFieldModel>? get fields => _fields;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> loadForm() async {
    _isLoading = true;
    notifyListeners();

    final result = await _authRepository.getRegisterFormFields();
    switch (result) {
      case Ok<List<FormFieldModel>> ok:
        _fields = ok.value;
        break;
      case Error<List<FormFieldModel>> error:
        debugPrint('Error loading form fields: ${error.error}');
        break;
    }

    _isLoading = false;
    notifyListeners();
  }

  final Map<String, dynamic> _formData = {};

  void updateField(String fieldName, dynamic value) {
    _formData[fieldName] = value;
    notifyListeners();
  }

  dynamic getFieldValue(String fieldName) {
    if (!_formData.containsKey(fieldName)) {
      return null;
    }
    return _formData[fieldName];
  }

  bool validate() {
    if (_fields == null) {
      return false;
    }
    for (var field in _fields!) {
      if (_formData[field.name] == null || (_formData[field.name] is List && _formData[field.name].isEmpty)) {
        return false;
      }
    }
    return true;
  }

  void clearForm() {
    _formData.clear();
    notifyListeners();
  }

  void resetForm() {
    _formData.clear();
    _fields = null;
    _isLoading = false;
    notifyListeners();
  }

  void register() {
    _authRepository.register(data: _formData).then((result) {
      switch (result) {
        case Ok<void> _:
          //TODO
          debugPrint('Registration successful');
          break;
        case Error<void> error:
          debugPrint('Error registering: ${error.error}');
          break;
      }
    });
  }
}
