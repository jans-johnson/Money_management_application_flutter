import 'package:flutter/material.dart';
import 'package:money_management_application/db/category/category_db.dart';
import 'package:money_management_application/screens/category/expense_category_list.dart';
import 'package:money_management_application/screens/category/income_category_list.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);

    CategoryDB().refreshUI();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(labelColor: Colors.black, controller: _tabController, tabs: [
          Tab(
            text: 'Income',
          ),
          Tab(
            text: 'Expense',
          ),
        ]),
        Expanded(
          child: TabBarView(controller: _tabController, children: [
            IncomeCategoryList(),
            ExpenseCategoryList(),
          ]),
        )
      ],
    );
  }
}
