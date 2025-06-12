import 'package:flutter/material.dart';
import 'package:found_you_app/domain/models/form_field/form_field_model.dart';
import 'package:found_you_app/utils/result.dart';

abstract class AuthRepository extends ChangeNotifier{
  Future<Result<void>> login({required String email, required String password, bool rememberMe = false});

  Future<Result<List<FormFieldModel>>> getRegisterFormFields();

  Future<Result<void>> register({required Map<String, dynamic> data});

  Future<Result<void>> logout();

  Future<Result<void>> resetPassword({required String oldPassword, required String newPassword});

  Future<bool> get isLogged;
}