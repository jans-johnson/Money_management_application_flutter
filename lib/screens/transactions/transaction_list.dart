import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:money_management_application/db/transactions/transaction_db.dart';
import 'package:money_management_application/models/category/category_model.dart';
import 'package:money_management_application/screens/transactions/screen_add_transaction.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionListNotifier,
        builder: (BuildContext context, newList, Widget? _) {
          Future.delayed(Duration.zero, () {
            if (newList.length <= 3)
              showToast(
                'Swipe Right For More Options \u{2192}',
                context: context,
                animation: StyledToastAnimation.fade,
                reverseAnimation: StyledToastAnimation.slideToRightFade,
                position: StyledToastPosition.center,
                animDuration: Duration(seconds: 1),
                duration: Duration(seconds: 3),
                curve: Curves.ease,
                reverseCurve: Curves.linear,
              );
          });

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
                    leading: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: newList[index].type != CategoryType.income
                                ? [
                                    Color.fromARGB(255, 162, 110, 125),
                                    Colors.red,
                                  ]
                                : [
                                    Color.fromARGB(255, 113, 230, 139),
                                    Colors.green,
                                  ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(
                          IconData(newList[index].category.categoryIcon,
                              fontFamily: 'MaterialIcons'),
                          color: Colors.black,
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
                    trailing: Text(
                      "\u{20B9}${newList[index].amount}",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: newList[index].type == CategoryType.income
                            ? Colors.green
                            : Colors.red,
                      ),
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
