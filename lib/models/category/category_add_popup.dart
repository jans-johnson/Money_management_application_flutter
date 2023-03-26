import 'package:flutter/material.dart';
import 'package:money_management_application/models/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryAddPopup(BuildContext context) async {
  showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (ctx1) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Container(
              child: Wrap(children: [
                TextField(
                  decoration: InputDecoration(
                      hintText: 'Category Name', icon: Icon(Icons.abc)),
                ),
                Row(
                  children: const [
                    RadioButton(title: 'Income', type: CategoryType.income),
                    RadioButton(title: 'Expense', type: CategoryType.expense),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
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
              ]),
            ),
          ),
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCategoryNotifier,
            builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
              return Radio<CategoryType>(
                value: type,
                groupValue: newCategory,
                onChanged: (value) {
                  if (value == null) return;
                  selectedCategoryNotifier.value = value;
                  selectedCategoryNotifier.notifyListeners();
                },
              );
            }),
        Text(title),
      ],
    );
  }
}
