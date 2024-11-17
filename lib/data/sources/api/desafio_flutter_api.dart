import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:login_app/core/constants/api_url.dart';
import 'package:login_app/core/exceptions/request_api_exception.dart';
import 'package:login_app/data/sources/api/http_interceptor.dart';

class DesafioFlutterApi {

  http.Client client = InterceptedClient.build(interceptors: [LoggerInterceptor()]);

  Future<String?> validatePassword(String password) async {
    try{
      http.Response response = await client.post(
          Uri.parse("${ApiUrl.baseUrl}/validate"),
          body: jsonEncode({"password": password}),
          headers: {
            "Content-Type": "application/json",
            "X-Author-Name": "Carlos Marques",
            "X-Author-Email": "carrlosmr@gmail.com"
          }
      ).timeout(const Duration(seconds: 5), onTimeout: (){
        throw RequestApiException(message: ApiUrl.exceededRequestTime, statusCode: 408);
      });

      if(response.statusCode == 202){
        var responseBody = jsonDecode(response.body);
        return responseBody["id"];
      }
      return null;
    }catch (e){
      if(e is RequestApiException){
        rethrow;
      }
      throw RequestApiException(message: "Erro interno do servidor", statusCode: 500);
    }
  }

}