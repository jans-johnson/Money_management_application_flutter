import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_management_application/models/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME = 'category-database';

abstract class TransactionDbFunctions {
  Future<List<TransactionModel>> getTransactions();
  Future<void> insertTransaction(TransactionModel value);
  Future<void> deleteTransaction(String categoryID);
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

  @override
  Future<void> deleteTransaction(String categoryID) {
    // TODO: implement deleteTransaction
    throw UnimplementedError();
  }

  Future<void> refreshUI() async {
    final _list = await getTransactions();
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);

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
