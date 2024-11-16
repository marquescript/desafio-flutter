import 'package:flutter/cupertino.dart';
import 'package:login_app/service/login_service.dart';

class LoginController {

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginService loginService = LoginService();

  String? validateInputPassword(String? value){
    if(value == null || value.isEmpty){
      return "Informe uma senha";
    }
    String error = loginService.validatePassword(value);
    return error.isNotEmpty ? error : null;
  }

  String? validateInputName(String? value){
    if(value == null || value.isEmpty){
      return "Informe um nome";
    }
    return null;
  }

  void dispose() {
    nameController.dispose();
    passwordController.dispose();
  }

}