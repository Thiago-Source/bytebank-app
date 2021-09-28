import 'package:bytebank_app/models/transaction_model.dart';
import 'package:bytebank_app/web_api/web_client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TransactionWebClient {
  final WebClient _webClient = WebClient();

  Future<List<Transaction>> getAll() async {
    final http.Response response = await _webClient.client.get(
      Uri.parse(WebClient.baseUrl),
    );
    final List<dynamic> jsonDecoded = jsonDecode(response.body);
    final List<Transaction> transactionsList = jsonDecoded.map((json) {
      return Transaction.fromMap(json);
    }).toList();

    return transactionsList;
  }

  Future<Transaction> postTransaction(
      Transaction transaction, String password) async {
    final http.Response response = await _webClient.client.post(
      Uri.parse(WebClient.baseUrl),
      headers: {
        'Content-type': 'application/json',
        'password': password,
      },
      body: jsonEncode(transaction.toMap()),
    );

    if (response.statusCode == 200) {
      final transactionJson = jsonDecode(response.body);
      return Transaction.fromMap(transactionJson);
    }
    throw HttpException(_getErrorMessage(response.statusCode));
  }
  static final Map<int, String> _statusResponses = {
    400: 'Erro 400: Valor de transferência inválida',
    401: 'Erro 401: Autenticação inválida',
    409: 'Erro 409: Id da transferência já existe',
  };

  String _getErrorMessage(int statusCode){
    if(_statusResponses.containsKey(statusCode)){
      return _statusResponses[statusCode]!;
    }
    return 'Erro desconhecido =(';
  }
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
