import 'package:flutter/material.dart';
import 'package:money_management_application/db/category/category_db.dart';
import 'package:money_management_application/models/category/category_model.dart';

Future<void> showTransactionAdd(BuildContext context) async {
  var _selectedDate = null;
  var _selectedType = CategoryType.income;
  showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (ctx1) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Container(
                  child: Wrap(
                    children: [
                      TextField(
                        decoration: InputDecoration(hintText: "Purpose"),
                      ),
                      TextField(
                        decoration: InputDecoration(hintText: "Amount"),
                        keyboardType: TextInputType.number,
                      ),
                      TextButton.icon(
                          onPressed: () async {
                            final _selectedDateTemp = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate:
                                    DateTime.now().subtract(Duration(days: 30)),
                                lastDate: DateTime.now());

                            if (_selectedDateTemp == null) {
                              return;
                            } else {
                              setState(() {
                                _selectedDate = _selectedDateTemp;
                              });
                            }
                          },
                          icon: Icon(Icons.calendar_today),
                          label: Text(_selectedDate == null
                              ? 'select date'
                              : _selectedDate.toString())),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [
                          Row(
                            children: [
                              Radio<CategoryType>(
                                  value: _selectedType,
                                  groupValue: CategoryType.income,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedType = CategoryType.income;
                                    });
                                  }),
                              Text('Income')
                            ],
                          ),
                          Row(
                            children: [
                              Radio<CategoryType>(
                                  value: _selectedType,
                                  groupValue: CategoryType.expense,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedType = CategoryType.expense;
                                    });
                                  }),
                              Text('Expense')
                            ],
                          )
                        ],
                      ),
                      
                    ],
                  ),
                )),
          );
        });
      });
}
