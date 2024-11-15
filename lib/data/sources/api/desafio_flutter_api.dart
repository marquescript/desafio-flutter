import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:login_app/core/exceptions/request_api_exception.dart';
import 'package:login_app/data/models/login_model.dart';
import 'package:login_app/data/sources/api/http_interceptor.dart';

class DesafioFlutterApi {

  static const String url = "https://desafioflutter-api.modelviewlabs.com";

  http.Client client = InterceptedClient.build(interceptors: [LoggerInterceptor()]);

  Future<String> validatePassword(Login login) async {
    http.Response response = await client.post(Uri.parse(url + "/validate"), body: {
      "password": login.password
    });

    if(response.statusCode != 202){
      throw RequestApiException(message: "Erro ao fazer a requisição.", statusCode: response.statusCode);
    }
    var responseBody = jsonDecode(response.body);
    return responseBody["id"];
  }

}