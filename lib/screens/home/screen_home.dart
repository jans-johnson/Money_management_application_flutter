import 'package:flutter/material.dart';
import 'package:money_management_application/db/category/category_db.dart';
import 'package:money_management_application/models/category/category_add_popup.dart';
import 'package:money_management_application/models/category/category_model.dart';
import 'package:money_management_application/screens/category/screen_category.dart';
import 'package:money_management_application/screens/home/widgets/bottom_navigation.dart';
import 'package:money_management_application/screens/transactions/screen_add_transaction.dart';
import 'package:money_management_application/screens/transactions/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [ScreenTransaction(), ScreenCategory()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Money Management"),
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      body: ValueListenableBuilder(
        valueListenable: selectedIndexNotifier,
        builder: (context, updatedIndex, child) {
          return _pages[updatedIndex];
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {

            showTransactionAdd(context);
          
          } else {
            showCategoryAddPopup(context);

          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
