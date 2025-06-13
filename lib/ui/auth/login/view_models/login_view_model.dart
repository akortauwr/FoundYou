import 'package:flutter/material.dart';
import 'package:found_you_app/data/repositories/auth/auth_repository.dart';
import 'package:found_you_app/utils/command.dart';
import 'package:found_you_app/utils/result.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  final emailController = TextEditingController(text: 'filip.kowalski45@example.pl');
  final passwordController = TextEditingController(text: 'password');

  bool rememberMe = false;
  bool _loginError = false;

  bool get loginError => _loginError;

  late Command1 login;

  LoginViewModel({required AuthRepository authRepository}) : _authRepository = authRepository {
    login = Command1<void, (String email, String password, bool rememberMe)>(_login);
  }

  void toggleRememberMe([bool? value]) {
    rememberMe = value ?? !rememberMe;
    notifyListeners();
  }

  Future<Result<void>> _login((String, String, bool) credentials) async {
    _loginError = false;
    notifyListeners();

    final (email, password, rememberMe) = credentials;
    final result = await _authRepository.login(email: email, password: password, rememberMe: rememberMe);

    if (result is Error<void>) {
      _loginError = true;
    }
    notifyListeners();
    return result;
  }

  Future<void> executeLogin() async {
    if (login.running) {
      return;
    }
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      _loginError = true;
      notifyListeners();
      return;
    }
    final email = emailController.text;
    final password = passwordController.text;
    final rememberMe = this.rememberMe;
    await login.execute((email, password, rememberMe));
  }

  void clear() {
    emailController.clear();
    passwordController.clear();
    rememberMe = false;
    _loginError = false;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
