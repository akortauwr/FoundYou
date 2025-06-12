import 'package:flutter/material.dart';
import 'package:found_you_app/data/repositories/auth/auth_repository.dart';
import 'package:found_you_app/domain/models/form_field/form_field_model.dart';
import 'package:found_you_app/domain/models/user_model/user_model.dart';
import 'package:found_you_app/utils/result.dart';

class EditDataViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  // Przechowujemy początkowy model użytkownika
  final UserModel initialUser;

  // ZMIANA: Konstruktor przyjmuje 'initialUser'
  EditDataViewModel({required AuthRepository authRepository, required this.initialUser})
      : _authRepository = authRepository;

  List<FormFieldModel>? _fields;
  List<FormFieldModel>? get fields => _fields;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final Map<String, dynamic> _formData = {};

  // ZMIANA: 'loadForm' teraz także inicjalizuje dane
  Future<void> loadForm() async {
    _isLoading = true;
    notifyListeners();

    final result = await _authRepository.getRegisterFormFields();
    switch (result) {
      case Ok<List<FormFieldModel>> ok:
        _fields = ok.value;
        // NOWOŚĆ: Po załadowaniu pól, wypełniamy je danymi użytkownika
        _initializeFormWithUserData();
        break;
      case Error<List<FormFieldModel>> error:
        debugPrint('Błąd ładowania pól formularza: ${error.error}');
        break;
    }

    _isLoading = false;
    notifyListeners();
  }

  // NOWOŚĆ: Prywatna metoda do inicjalizacji danych w formularzu
  void _initializeFormWithUserData() {
    if (_fields == null) return;

    // Używamy metody .toJson() wygenerowanej przez freezed/json_serializable,
    // aby łatwo uzyskać mapę danych z modelu użytkownika.
    final userMap = initialUser.toJson();

    for (var field in _fields!) {
      // Sprawdzamy, czy w danych użytkownika istnieje klucz pasujący do nazwy pola
      if (userMap.containsKey(field.name)) {
        var value = userMap[field.name];
        // Ważne: Musimy obsłużyć specjalne typy, takie jak DateTime,
        // ponieważ JSON przechowuje je jako stringi.
        if (field.name == 'birthday' && value is String) {
          _formData[field.name] = DateTime.tryParse(value);
        } else {
          _formData[field.name] = value;
        }
      }
    }
    // Nie musimy tutaj wywoływać notifyListeners(), ponieważ jest na końcu `loadForm()`.
  }


  void updateField(String fieldName, dynamic value) {
    _formData[fieldName] = value;
    notifyListeners();
  }

  // Ta metoda teraz będzie poprawnie zwracać zainicjalizowane dane
  dynamic getFieldValue(String fieldName) {
    return _formData[fieldName];
  }

  bool validate() {
    if (_fields == null) return false;

    for (var field in _fields!) {
      // Walidacja dla pól wymaganych

        final value = _formData[field.name];
        if (value == null || (value is String && value.isEmpty) || (value is List && value.isEmpty)) {
          return false;
      }
    }
    return true;
  }

  // ZMIANA: Z 'register' na 'saveChanges'
  // Metoda zwraca Future<Result<void>>, aby UI mogło zareagować na sukces/błąd
  Future<Result<void>> saveChanges() async {
    // Tutaj możesz dodać logikę ładowania, jeśli chcesz
    // np. _isLoading = true; notifyListeners();

    // Zakładam, że w repozytorium masz metodę `updateProfile` lub podobną
    final result = await _authRepository.register(data: _formData);

    // Po zakończeniu operacji
    // np. _isLoading = false; notifyListeners();

    return result;
  }

  // Pozostałe metody bez zmian
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