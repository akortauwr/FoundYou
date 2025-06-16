import 'package:flutter/material.dart';
import 'package:found_you_app/data/repositories/auth/auth_repository.dart';
import 'package:found_you_app/data/repositories/profile/profile_repository.dart';
import 'package:found_you_app/domain/models/form_field/form_field_model.dart';
import 'package:found_you_app/domain/models/user_model/user_model.dart';
import 'package:found_you_app/utils/result.dart';

class EditDataViewModel extends ChangeNotifier {
  final ProfileRepository _profileRepository;
  final AuthRepository _authRepository;

  EditDataViewModel({required ProfileRepository profileRepository, required AuthRepository authRepository})
    : _profileRepository = profileRepository,
      _authRepository = authRepository;

  List<FormFieldModel>? _fields;

  List<FormFieldModel>? get fields => _fields;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  final Map<String, dynamic> _formData = {};
  final Map<String, String> _errors = {};

  Map<String, String> get errors => _errors;

  Future<void> loadInitialData() async {
    _isLoading = true;
    notifyListeners();

    final formFieldsResult = await _authRepository.getRegisterFormFields();
    final userProfileResult = await _profileRepository.loadProfile();

    if (formFieldsResult is Ok<List<FormFieldModel>> && userProfileResult is Ok<UserModel>) {
      _fields = formFieldsResult.value;
      _prefillForm(userProfileResult.value, _fields!);
    } else {
      debugPrint('Error loading initial data for edit form.');
      if (formFieldsResult is Error) {
        debugPrint('Form fields error: $formFieldsResult');
      }
      if (userProfileResult is Error) {
        debugPrint('User profile error: $userProfileResult');
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  void _prefillForm(UserModel user, List<FormFieldModel> formFields) {
    _formData['username'] = user.username;
    _formData['bio'] = user.bio;

    if (user.birthday.isNotEmpty) {
      final parts = user.birthday.split('-');
      if (parts.length == 3) {
        _formData['birthday'] = '${parts[2]}${parts[1]}${parts[0]}';
      }
    }

    final sexField = formFields.firstWhere(
      (f) => f.name == 'sex',
      orElse: () => throw Exception("Sex field not found"),
    );
    final sexOption = sexField.options.firstWhere(
      (opt) => opt.name == user.sex,
      orElse: () => throw Exception("Sex option not found"),
    );
    _formData['sex'] = sexOption.value;

    final passionsField = formFields.firstWhere(
      (f) => f.name == 'passions',
      orElse: () => throw Exception("Passions field not found"),
    );
    _formData['passions'] =
        user.passions.map((passionName) {
          return passionsField.options.firstWhere((opt) => opt.name == passionName).value;
        }).toList();

    _formData['profile_image'] = user.imageUrl;
  }

  dynamic getFieldValue(String fieldName) {
    return _formData[fieldName];
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

    _formData['birthday_formatted'] = '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
    return null;
  }

  bool validate() {
    if (_fields == null) return false;
    for (var field in _fields!) {
      final value = _formData[field.name];
      if (field.name != 'profile_image' &&
          (value == null || (value is List && value.isEmpty) || (value is String && value.isEmpty))) {
        return false;
      }
    }
    return _errors.isEmpty;
  }

  Future<bool> updateProfile() async {
    if (!validate()) {
      debugPrint('Update blocked due to validation errors or empty fields.');
      return false;
    }

    final Map<String, dynamic> apiData = Map.from(_formData);

    apiData['sex_id'] = apiData['sex'];
    apiData['passions_ids'] = apiData['passions'];
    if (apiData['birthday_formatted'] == null) {
      apiData.remove('birthday');
    }

    final dynamic imageValue = _formData['profile_image'];
    if (imageValue is String && imageValue.startsWith('http')) {
      apiData.remove('profile_image');
    }

    apiData.remove('sex');
    apiData.remove('passions');
    apiData.remove('birthday_formatted');

    final result = await _profileRepository.updateProfile(data: apiData);

    switch (result) {
      case Ok<void> _:
        debugPrint('Profile update successful');
        return true;
      case Error<void> error:
        debugPrint('Error updating profile: ${error.error}');
        return false;
    }
  }
}
