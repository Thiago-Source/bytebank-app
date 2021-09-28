import 'package:bytebank_app/web_api/interceptors/logging_interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

class WebClient {
  static const String baseUrl = 'http://19.7.2.101:8080/transactions';

  final http.Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
    requestTimeout: const Duration(seconds: 5),
  );
  WebClient();
}
