import 'package:bytebank_app/web_api/interceptors/logging_interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

class WebClient {
  static const String baseUrl = 'http://10.0.0.109:8080/transactions';

  final http.Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );
  WebClient();

  
}
