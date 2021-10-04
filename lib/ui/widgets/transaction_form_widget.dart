import 'package:bytebank_app/models/contact_model.dart';
import 'package:flutter/material.dart';

class TransactionFormWidget extends StatelessWidget {
  const TransactionFormWidget({
    Key? key,
    required this.contact,
    required TextEditingController valueController,
    required this.transactionId,
  })  : _valueController = valueController,
        super(key: key);

  final ContactModel contact;
  final TextEditingController _valueController;
  final String transactionId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contact.nome,
          style: const TextStyle(
            fontSize: 24.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            contact.numero.toString(),
            style: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: TextField(
            controller: _valueController,
            style: const TextStyle(fontSize: 24.0),
            decoration: const InputDecoration(labelText: 'Value'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
      ],
    );
  }
}
