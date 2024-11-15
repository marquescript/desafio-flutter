import 'package:login_app/data/models/login_model.dart';
import 'package:login_app/data/sources/api/desafio_flutter_api.dart';

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


}