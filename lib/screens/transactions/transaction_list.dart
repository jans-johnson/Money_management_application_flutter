import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management_application/db/category/category_db.dart';
import 'package:money_management_application/db/transactions/transaction_db.dart';
import 'package:money_management_application/models/category/category_model.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionListNotifier,
        builder: (BuildContext context, newList, Widget? _) {
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 50,
                    child: Text(
                      DateFormat.MMMd().format(newList[index].date),
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: newList[index].type == CategoryType.income
                        ? Colors.green
                        : Colors.red,
                    foregroundColor: Colors.black,
                  ),
                  title: Text(newList[index].amount.toString()),
                  subtitle: Text(newList[index].purpose),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => TransactionDB.instance
                        .deleteTransaction(newList[index].id),
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(
                height: 2,
              );
            },
            itemCount: newList.length,
          );
        });
  }
}