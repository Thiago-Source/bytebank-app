import 'package:bytebank_app/ui/widgets/transaction_card.dart';
import 'package:bytebank_app/web_api/web_clients/transaction_web_client.dart';
import '../../models/transaction_model.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatefulWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  final TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transações'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _webClient.getAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;

            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());

            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Transaction> transactions = snapshot.data!;
                if (transactions.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactions[index];
                      return TransactionCard(
                        transaction: transaction,
                        onTap: () {},
                      );
                    },
                    itemCount: transactions.length,
                  );
                }
              }
              break;
            default:
              const CircularProgressIndicator();
          }
          return const Center(
            child: Text('Erro desconhecido! =('),
          );
        },
      ),
    );
  }
}


