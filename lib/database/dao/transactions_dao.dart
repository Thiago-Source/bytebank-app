import 'dart:async';

import 'package:bytebank_app/models/transaction_model.dart';
import 'package:bytebank_app/ui/widgets/response_dialog.dart';
import 'package:bytebank_app/web_api/web_clients/transaction_web_client.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class TransactionsDao {
  final TransactionWebClient _webClient = TransactionWebClient();

  Future<Transaction?> sendTransaction(
      Transaction transaction, String password, BuildContext context) async {
    final Transaction? newTransaction = await _webClient
        .postTransaction(transaction, password)
        .catchError((error) {
      if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
        FirebaseCrashlytics.instance
            .setCustomKey('exception', error.toString());
        FirebaseCrashlytics.instance
            .setCustomKey('exception', transaction.toString());
        FirebaseCrashlytics.instance.recordError(error.message, null);
      }

      showDialog(
          context: context,
          builder: (contextDialog) {
            return FailureDialog(error.message);
          });
    }, test: (error) => error is TimeoutException).catchError((error) {
      if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
        FirebaseCrashlytics.instance
            .setCustomKey('exception', error.toString());
        FirebaseCrashlytics.instance
            .setCustomKey('http_code', error.statusCode);
        FirebaseCrashlytics.instance
            .setCustomKey('exception', transaction.toString());
        FirebaseCrashlytics.instance.recordError(error.message, null);
      }

      showDialog(
          context: context,
          builder: (contextDialog) {
            return const FailureDialog('Tempo do processo excedido');
          });
    }, test: (error) => error is HttpException).catchError((error) {
      if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
        FirebaseCrashlytics.instance
            .setCustomKey('exception', error.toString());
        FirebaseCrashlytics.instance
            .setCustomKey('exception', transaction.toString());
        FirebaseCrashlytics.instance.recordError(error.message, null);
      }

      showDialog(
          context: context,
          builder: (contextDialog) {
            return const FailureDialog('Erro desconhecido');
          });
    }, test: (error) => error is Exception);
    return newTransaction;
  }
}
