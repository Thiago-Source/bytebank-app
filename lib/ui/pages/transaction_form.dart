import 'package:bytebank_app/blocs/container/container.dart';
import 'package:bytebank_app/blocs/transactions_bloc.dart';
import 'package:bytebank_app/models/contact_model.dart';
import 'package:bytebank_app/models/transaction_model.dart';
import 'package:bytebank_app/ui/widgets/auth_dialog.dart';
import 'package:bytebank_app/ui/widgets/response_dialog.dart';
import 'package:bytebank_app/ui/widgets/transaction_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

abstract class TransactionFormState {
  const TransactionFormState();
}

class SendingState extends TransactionFormState {
  const SendingState();
}

class ShowingFormState extends TransactionFormState {
  const ShowingFormState();
}

class SentState extends TransactionFormState {
  const SentState();
}

class ErrorState extends TransactionFormState {
  final String message = "Error";
  const ErrorState();
}

class TransactionFormCubit extends Cubit<TransactionFormState> {
  TransactionFormCubit() : super(const ShowingFormState());
}

class TransactionFormContainer extends BlocContainer {
  final ContactModel contact;
  const TransactionFormContainer(this.contact, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionFormCubit>(
      create: (BuildContext context) {
        return TransactionFormCubit();
      },
      child: TransactionForm(contact),
    );
  }
}

class TransactionForm extends StatelessWidget {
  final ContactModel contact;

  TransactionForm(this.contact, {Key? key}) : super(key: key);
  final TransactionBloc _transactionBloc = TransactionBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormCubit, TransactionFormState>(
      builder: (context, state) {
        if (state is SendingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SentState) {
          Navigator.pop(context);
        }

        if (state is ShowingFormState) {
          return BasicForm(_transactionBloc, contact);
        }

        return const Center(child: Text("Erro!!"));
      },
    );
  }
}

class BasicForm extends StatelessWidget {
  final TextEditingController _valueController = TextEditingController();
  final String transactionId = const Uuid().v4();
  final TransactionBloc transactionBloc;
  final ContactModel contact;
  BasicForm(this.transactionBloc, this.contact, {Key? key}) : super(key: key);

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
                  contact: contact,
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
                            Transaction(transactionId, value, contact);
                        showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return AuthDialog(
                              onTap: (String password) async {
                                await transactionBloc.saveTransaction(
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
                    },
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
