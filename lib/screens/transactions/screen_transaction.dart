import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management_application/db/category/category_db.dart';
import 'package:money_management_application/db/transactions/transaction_db.dart';
import 'package:money_management_application/models/category/category_model.dart';
import 'package:money_management_application/models/transaction/transaction_model.dart';
import 'package:money_management_application/screens/transactions/transaction_list.dart';
import 'package:money_management_application/screens/transactions/week_comparison.dart';

class ScreenTransaction extends StatefulWidget {
  const ScreenTransaction({super.key});

  @override
  State<ScreenTransaction> createState() => _ScreenTransactionState();
}

class _ScreenTransactionState extends State<ScreenTransaction> {

  @override
  void initState() {
    // TODO: implement initState
    TransactionDB.instance.refreshUI();
    CategoryDB.instance.refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WeekComparison(),
        Expanded(child: TransactionList()),
      ],
    );
  }
}
