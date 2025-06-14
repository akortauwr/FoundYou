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

  final Map<String, dynamic> _formData = {};

  final Map<String, String> _errors = {};

  Map<String, String> get errors => _errors;

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

  dynamic getFieldValue(String fieldName) {
    return _formData[fieldName];
  }

  void clearForm() {
    _formData.clear();
    _errors.clear();
    notifyListeners();
  }

  void resetForm() {
    _formData.clear();
    _fields = null;
    _isLoading = false;
    _errors.clear();
    notifyListeners();
  }

  String? _validateDate(String dateString) {
    if (dateString.length != 8) {
      return null;
    }

    final day = int.tryParse(dateString.substring(0, 2));
    final month = int.tryParse(dateString.substring(2, 4));
    final year = int.tryParse(dateString.substring(4, 8));

    if (day == null || month == null || year == null) {
      return "Nieprawidłowy format daty.";
    }

    DateTime? birthDate;
    try {
      birthDate = DateTime(year, month, day);
      if (birthDate.day != day || birthDate.month != month || birthDate.year != year) {
        throw const FormatException();
      }
    } catch (e) {
      return "Data nie istnieje.";
    }

    final now = DateTime.now();
    if (birthDate.isAfter(now)) {
      return "Podaj prawidłową datę urodzenia.";
    }

    int age = now.year - birthDate.year;
    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    if (age < 18) {
      return "Musisz mieć ukończone 18 lat.";
    }

    if (age > 150) {
      return "Wiek nie może przekraczać 150 lat.";
    }

    _formData['birthday'] = '$year-$month-$day';
    return null;
  }

  void updateField(String fieldName, dynamic value) {
    _formData[fieldName] = value;

    if (fieldName == 'birthday' && value is String) {
      final error = _validateDate(value);
      if (error != null) {
        _errors[fieldName] = error;
      } else {
        _errors.remove(fieldName);
      }
    }

    notifyListeners();
  }

  bool validate() {
    if (_fields == null) return false;
    for (var field in _fields!) {
      final value = _formData[field.name];
      if (value == null || (value is List && value.isEmpty) || (value is String && value.isEmpty)) {
        return false;
      }
    }

    return _errors.isEmpty;
  }

  Future<bool> register() async {
    if (!validate()) {
      debugPrint('Registration blocked due to validation errors or empty fields.');
      return false;
    }

    _formData['sex_id'] = _formData['sex'];
    _formData['passions_ids'] = _formData['passions'];

    final result = await _authRepository.register(data: _formData);

    switch (result) {
      case Ok<void> _:
        debugPrint('Registration successful');
        clearForm();
        return true;
      case Error<void> error:
        debugPrint('Error registering: ${error.error}');
        return false;
    }
  }
}
