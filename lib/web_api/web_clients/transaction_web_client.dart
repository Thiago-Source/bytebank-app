import 'package:bytebank_app/models/contact_model.dart';
import 'package:bytebank_app/models/transaction_model.dart';
import 'package:bytebank_app/web_api/web_client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TransactionWebClient {
  final WebClient _webClient = WebClient();

  Future<List<Transaction>> getAll() async {
    final http.Response response = await _webClient.client
        .get(
          Uri.parse(WebClient.baseUrl),
        )
        .timeout(
          const Duration(seconds: 5),
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
    final transactionJson = jsonDecode(response.body);
    return Transaction(
      transactionJson['value'],
      ContactModel(
        nome: transactionJson['contact']['name'],
        numero: transactionJson['contact']['accountNumber'],
      ),
    );
  }
}
