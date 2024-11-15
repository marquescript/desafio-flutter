import 'package:login_app/data/models/login_model.dart';
import 'package:login_app/data/sources/api/desafio_flutter_api.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginService {

  DesafioFlutterApi api = DesafioFlutterApi();

  Future<bool> sendPassword(Login login) async {
    try{
      String response = await api.validatePassword(login.password);
      if(response.isNotEmpty){
        return true;
      }
      return false;
    }catch (e){
      return false;
    }
  }

  String validatePassword(Login login){
    MultiValidator passwordValidator = MultiValidator([
      MinLengthValidator(8, errorText: "A senha deve possuir no mínimo 8 caracteres"),
      PatternValidator(r'[0-9]', errorText: "A senha deve possuir no mínimo 1 número"),
      PatternValidator(r'[A-Z]', errorText: "A senha deve possuir no mínimo 1 caracter maiúsculo"),
      PatternValidator(r'[a-z]', errorText: "A senha deve possuir no mínimo 1 caracter maiúsculo"),
      PatternValidator(r'[!@#$%^&*(),.?":{}|<>]', errorText: "A senha deve possuir no mínimo 1 caracter especial")
    ]);

    String? errorMessage = passwordValidator(login.password);

    return errorMessage ?? "";
  }


}