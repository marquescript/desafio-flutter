import 'package:login_app/core/constants/login_error.dart';
import 'package:login_app/data/models/login_model.dart';
import 'package:login_app/data/sources/api/desafio_flutter_api.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginService {

  DesafioFlutterApi api = DesafioFlutterApi();

  Future<bool> sendPassword(Login login) async {
    try{
      String? response = await api.validatePassword(login.password);
      return response != null;
    }catch (e){
      return false;
    }
  }

  String validatePassword(String password){
    MultiValidator passwordValidator = MultiValidator([
      MinLengthValidator(8, errorText: LoginError.invalidCharacterQuantity),
      PatternValidator(r'[0-9]', errorText: LoginError.numberIsRequired),
      PatternValidator(r'[A-Z]', errorText: LoginError.uppercaseCharacterIsRequired),
      PatternValidator(r'[a-z]', errorText: LoginError.lowercaseCharacterIsRequired),
      PatternValidator(r'[!@#$%^&*(),.?":{}|<>]', errorText: LoginError.specialCharacterIsRequired)
    ]);

    String? errorMessage = passwordValidator(password);

    return errorMessage ?? "";
  }


}