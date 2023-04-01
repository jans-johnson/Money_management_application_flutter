import 'dart:math';

import 'package:flutter/material.dart';
import 'package:money_management_application/db/category/category_db.dart';
import 'package:money_management_application/db/transactions/transaction_db.dart';
import 'package:money_management_application/models/category/category_model.dart';
import 'package:money_management_application/models/transaction/transaction_model.dart';

final _purposeController = TextEditingController();
final _amountController = TextEditingController();
var _selectedDate = null;
var _categoryID = null;
var _selectedType = CategoryType.income;
CategoryModel? _selectedCategoryModel;
Future<void> showTransactionAdd(BuildContext context) async {
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
                        controller: _purposeController,
                      ),
                      TextField(
                        decoration: InputDecoration(hintText: "Amount"),
                        keyboardType: TextInputType.number,
                        controller: _amountController,
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
                                      _categoryID = null;
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
                                      _categoryID = null;
                                    });
                                  }),
                              Text('Expense')
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          DropdownButton(
                              hint: const Text("Select Category"),
                              value: _categoryID,
                              items: (_selectedType == CategoryType.income
                                      ? CategoryDB().incomeCategoryList
                                      : CategoryDB().expenseCategoryList)
                                  .value
                                  .map((e) {
                                return DropdownMenuItem(
                                  child: Text(e.name),
                                  value: e.id,
                                  onTap: () {
                                    _selectedCategoryModel = e;
                                  },
                                );
                              }).toList(),
                              onChanged: (selectedValue) {
                                setState(() {
                                  _categoryID = selectedValue;
                                });
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    addTransaction();
                                    Navigator.of(ctx1).pop();
                                  },
                                  child: Text('Add')),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(ctx1).pop();
                                  },
                                  child: Text('Cancel'))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )),
          );
        });
      });
}

Future<void> addTransaction() async {
  final _purposeText = _purposeController.text;
  final _amountText = _amountController.text;
  final _amount = double.tryParse(_amountText);
  if (_amount == null) return;
  if (_purposeText.isEmpty ||
      _amountText.isEmpty ||
      _categoryID == null ||
      _selectedDate == null) return;

  final _model = TransactionModel(
      purpose: _purposeText,
      amount: _amount,
      date: _selectedDate,
      type: _selectedType,
      category: _selectedCategoryModel!,
      id: DateTime.now().millisecondsSinceEpoch.toString());
  TransactionDB.instance.insertTransaction(_model);
}
