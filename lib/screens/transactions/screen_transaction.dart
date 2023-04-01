import 'package:flutter/material.dart';
import 'package:money_management_application/db/transactions/transaction_db.dart';

class ScreenTransaction extends StatefulWidget {
  const ScreenTransaction({super.key});

  @override
  State<ScreenTransaction> createState() => _ScreenTransactionState();
}

class _ScreenTransactionState extends State<ScreenTransaction> {
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
                        '12\ndec',
                        textAlign: TextAlign.center,
                      )),
                  title: Text(newList[index].amount.toString()),
                  subtitle: Text(newList[index].purpose),
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
