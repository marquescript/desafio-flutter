class RequestApiException implements Exception{

  final String message;
  final int? statusCode;

  RequestApiException({required this.message, this.statusCode});

  @override
  String toString() {
    return 'Erro: $message (Status Code: $statusCode)';
  }

}