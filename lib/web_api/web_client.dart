import 'package:bytebank_app/web_api/interceptors/logging_interceptor.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

class WebClient {
  static const String baseUrl = 'INSIRA_SEU_LOCALHOST_AQUI';

  final http.Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
    requestTimeout: const Duration(seconds: 5),
  );
  WebClient();
}
