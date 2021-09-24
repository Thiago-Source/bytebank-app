import 'package:bytebank_app/models/transaction_model.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key? key,
    required this.transaction,
    required this.onTap,
  }) : super(key: key);

  final Transaction transaction;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: const Icon(Icons.monetization_on, size: 40),
        title: Text(
          'R\$ ${transaction.value.toString()}',
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          'Para: ${transaction.contact.nome} - nº ${transaction.contact.numero.toString()}',
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}