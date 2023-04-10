import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:money_management_application/db/transactions/transaction_db.dart';
import 'package:money_management_application/models/category/category_model.dart';
import 'package:money_management_application/models/transaction/transaction_model.dart';
import 'package:intl/intl.dart';
import 'package:money_management_application/screens/transactions/chart_bar.dart';

class WeekComparison extends StatelessWidget {
// List<TransactionModel> get _recentTransactions {
//     return TransactionDB.instance.list.where((tx) {
//       return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
//     }).toList();
//   }

  List<TransactionModel> recentTransactions = [];

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionListNotifier,
        builder:
            (BuildContext context, List<TransactionModel> newList, Widget? _) {
          recentTransactions = newList.where((tx) {
            return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
          }).toList();

          return Card(
            elevation: 6,
            margin: EdgeInsets.all(20),
            child: Row(
              children: groupedTransactionValues.map((data) {
                return ChartBar(
                    data['day'].toString(),
                    data['amount'] as double,
                    totalSpending==0.0 ? 0.0 :(data['amount'] as double) / totalSpending);
              }).toList(),
            ),
          );
        });
  }
}
