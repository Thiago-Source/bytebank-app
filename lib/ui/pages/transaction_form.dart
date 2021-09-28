import 'package:bytebank_app/blocs/transactions_bloc.dart';
import 'package:bytebank_app/models/contact_model.dart';
import 'package:bytebank_app/models/transaction_model.dart';
import 'package:bytebank_app/ui/widgets/auth_dialog.dart';
import 'package:bytebank_app/ui/widgets/response_dialog.dart';
import 'package:bytebank_app/ui/widgets/transaction_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final ContactModel contact;

  const TransactionForm(this.contact, {Key? key}) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionBloc _transactionBloc = TransactionBloc();
  final String transactionId = const Uuid().v4();
  bool isSending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TransactionFormWidget(
                  widget: widget,
                  valueController: _valueController,
                  transactionId: transactionId),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: const Text('Transfer'),
                    onPressed: () async {
                      if (_valueController.text.isNotEmpty) {
                        final double value =
                            double.parse(_valueController.text);
                        final transactionCreated =
                            Transaction(transactionId, value, widget.contact);
                        showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return AuthDialog(
                              onTap: (String password) async {
                                setState(() {
                                  isSending = true;
                                });
                                await _transactionBloc.saveTransaction(
                                    transactionCreated, password, context);
                              },
                            );
                          },
                        );
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const FailureDialog(
                                  'O valor não pode ser nulo!');
                            });
                      }
                      setState(() {
                        isSending = false;
                      });
                    },
                  ),
                ),
              ),
              Visibility(
                visible: isSending,
                child: Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Carregando...'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
