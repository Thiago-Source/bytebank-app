import 'dart:async';
import 'package:bytebank_app/database/dao/transactions_dao.dart';
import 'package:bytebank_app/models/transaction_model.dart';
import 'package:bytebank_app/ui/widgets/response_dialog.dart';
import 'package:flutter/material.dart';

class TransactionBloc {
  final TransactionsDao _transactionsDao = TransactionsDao();

  Future saveTransaction(
    Transaction transaction,
    String password,
    BuildContext context,
  ) async {
    Transaction? newTransaction =
        await _transactionsDao.sendTransaction(transaction, password, context);

    if (newTransaction != null) {
      await showDialog(
          context: context,
          builder: (contextSuccess) {
            return const SuccessDialog('Transferência realizada com sucesso!');
          });
      Navigator.pop(context);
    }
  }
}
