import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:money_management_application/db/category/category_db.dart';
import 'package:money_management_application/db/transactions/transaction_db.dart';
import 'package:money_management_application/models/category/category_model.dart';
import 'package:money_management_application/screens/transactions/screen_add_transaction.dart';

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
              return Slidable(
                key: const ValueKey(0),
                startActionPane:
                    ActionPane(motion: const DrawerMotion(), children: [
                  SlidableAction(
                    onPressed: (_) => TransactionDB.instance
                        .deleteTransaction(newList[index].id),
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    onPressed: (_) {
                      showTransactionAdd(context, newList[index]);
                    },
                    backgroundColor: Color(0xFF21B7CA),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                ]),
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        radius: 27,
                        backgroundColor:
                            newList[index].type == CategoryType.income
                                ? Colors.green
                                : Colors.red,
                        foregroundColor: Colors.black,
                        child: Text(
                          "\u{20B9}${newList[index].amount}",
                          textAlign: TextAlign.center,
                          textScaleFactor: 0.9,
                        ),
                      ),
                    ),
                    title: Text(
                      newList[index].purpose,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      DateFormat.MMMd().format(newList[index].date),
                    ),
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
