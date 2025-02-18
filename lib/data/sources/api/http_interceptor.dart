import 'package:http_interceptor/http_interceptor.dart';
import 'package:logger/logger.dart';

class LoggerInterceptor extends InterceptorContract {

  Logger log = Logger();

  @override
  Future<BaseRequest> interceptRequest({
    required BaseRequest request,
  }) async {
    log.t('----- Request -----');
    log.t(request.toString());
    log.t(request.headers.toString());
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    log.i('----- Response -----');

    if (response.statusCode ~/ 100 == 2) {
      log.i('Code: ${response.statusCode}');
    } else {
      log.e('Code: ${response.statusCode}');
    }

    if (response is Response) {
      var responseBody = response.body;
      log.i('Response Body: $responseBody');
    }

    return response;
  }

}