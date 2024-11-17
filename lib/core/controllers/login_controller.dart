import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_app/data/models/login_model.dart';
import 'package:login_app/service/login_service.dart';

class LoginController {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginService loginService = LoginService();

  bool isLoading = false;

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

  Future<bool> sendLogin(Login login) async {
    return loginService.sendPassword(login);
  }

  Future<bool?> handleLogin({
    required GlobalKey<FormState> formLoginKey,
    required BuildContext context,
    required Function(void Function()) setStateCallback,
    Future<bool> Function(Login login)? sendLoginCallback })
  async {
    if (formLoginKey.currentState!.validate()) {
      setStateCallback(() {
        isLoading = true;
      });
      Login login = Login(
        name: nameController.text,
        password: passwordController.text,
      );

      bool response = await (sendLoginCallback?.call(login) ?? sendLogin(login));

      setStateCallback(() {
        isLoading = false;
      });

      if(response){
        nameController.clear();
        passwordController.clear();
        return true;
      }

      return false;
    }
    return null;
  }

}
