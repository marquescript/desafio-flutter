import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_app/data/models/login_model.dart';
import 'package:login_app/service/login_service.dart';
import '../../core/constants/login_error.dart';

class LoginController {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginService loginService = LoginService();

  Function(bool isLoading)? onLoadingChanged;

  Future<bool> sendLogin(Login login) async {
    return loginService.sendPassword(login);
  }

  Future<void> handleLogin(
      BuildContext context, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {

      onLoadingChanged?.call(true);

      Login login = Login(
        name: nameController.text,
        password: passwordController.text,
      );

      bool response = await sendLogin(login);

      onLoadingChanged?.call(false);

      if (response) {
        Navigator.pushNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(LoginError.errorConnectingToServer),
          ),
        );
      }
    }
  }

  String? validateInputPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Informe uma senha";
    }
    String error = loginService.validatePassword(value);
    return error.isNotEmpty ? error : null;
  }

  String? validateInputName(String? value) {
    if (value == null || value.isEmpty) {
      return "Informe um nome";
    }
    return null;
  }

  void dispose() {
    nameController.dispose();
    passwordController.dispose();
  }
}
