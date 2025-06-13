import 'package:flutter/material.dart';
import 'package:found_you_app/data/repositories/auth/auth_repository.dart';
import 'package:found_you_app/domain/models/form_field/form_field_model.dart';
import 'package:found_you_app/domain/models/user_model/user_model.dart';
import 'package:found_you_app/utils/result.dart';

class EditDataViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  final UserModel initialUser;

  EditDataViewModel({required AuthRepository authRepository, required this.initialUser})
    : _authRepository = authRepository;

  List<FormFieldModel>? _fields;

  List<FormFieldModel>? get fields => _fields;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  final Map<String, dynamic> _formData = {};

  Future<void> loadForm() async {
    _isLoading = true;
    notifyListeners();

    final result = await _authRepository.getRegisterFormFields();
    switch (result) {
      case Ok<List<FormFieldModel>> ok:
        _fields = ok.value;
        _initializeFormWithUserData();
        break;
      case Error<List<FormFieldModel>> error:
        debugPrint('Błąd ładowania pól formularza: ${error.error}');
        break;
    }

    _isLoading = false;
    notifyListeners();
  }

  void _initializeFormWithUserData() {
    if (_fields == null) return;

    final userMap = initialUser.toJson();

    for (var field in _fields!) {
      if (userMap.containsKey(field.name)) {
        var value = userMap[field.name];

        if (field.name == 'birthday' && value is String) {
          _formData[field.name] = DateTime.tryParse(value);
        } else {
          _formData[field.name] = value;
        }
      }
    }
  }

  void updateField(String fieldName, dynamic value) {
    _formData[fieldName] = value;
    notifyListeners();
  }

  dynamic getFieldValue(String fieldName) {
    return _formData[fieldName];
  }

  bool validate() {
    if (_fields == null) return false;

    for (var field in _fields!) {
      final value = _formData[field.name];
      if (value == null || (value is String && value.isEmpty) || (value is List && value.isEmpty)) {
        return false;
      }
    }
    return true;
  }

  Future<Result<void>> saveChanges() async {
    final result = await _authRepository.register(data: _formData);

    return result;
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
}
