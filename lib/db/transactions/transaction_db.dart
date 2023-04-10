import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_management_application/models/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction-database';

abstract class TransactionDbFunctions {
  Future<List<TransactionModel>> getTransactions();
  Future<void> insertTransaction(TransactionModel value);
  Future<void> deleteTransaction(String transactionID);
}

class TransactionDB implements TransactionDbFunctions {
  //making object singleton
  TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);

  List<TransactionModel> list=[];

  @override
  Future<void> deleteTransaction(String transactionID) async {
    final _transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _transactionDB.delete(transactionID);
    refreshUI();
  }

  Future<void> refreshUI() async {
    list = await getTransactions();
    list.sort((first, second) => first.date.compareTo(second.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(list);

    transactionListNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final _transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _transactionDB.values.toList();
  }

  @override
  Future<void> insertTransaction(TransactionModel value) async {
    final _transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _transactionDB.put(value.id, value);
    refreshUI();
  }
}
