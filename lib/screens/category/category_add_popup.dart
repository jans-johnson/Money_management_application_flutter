import 'package:flutter/material.dart';
import 'package:money_management_application/db/category/category_db.dart';
import 'package:money_management_application/models/category/category_model.dart';
import 'package:modern_icon_picker/Icon_picker_untils.dart';
import 'package:modern_icon_picker/flutter_icon_picker.dart';
import 'package:modern_icon_picker/flutter_icons_data.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);
int? _icon=null;

Future<void> showCategoryAddPopup(BuildContext context) async {
  final _nameEditingController = TextEditingController();
  showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (ctx1) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          _pickIcon() async {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Choose an icon !'),
                content: FlutterIconPicker(
                  randomIconColors: false,
                  onChanged: (value) {
                    setState(() {
                      _icon = value['flutter_icon'].codePoint;
                    });
                  },
                ),
              ),
            );
          }

          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Container(
                child: Wrap(children: [
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Category Name', icon: Icon(Icons.abc)),
                    controller: _nameEditingController,
                  ),
                  Row(
                    children: const [
                      RadioButton(title: 'Income', type: CategoryType.income),
                      RadioButton(title: 'Expense', type: CategoryType.expense),
                    ],
                  ),
                  TextButton.icon(
                      onPressed: _pickIcon,
                      icon: _icon == null
                          ? Icon(Icons.add)
                          : Icon(IconData(_icon!, fontFamily: 'MaterialIcons')),
                      label: Text("Select an Icon")),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            final _name = _nameEditingController.text;
                            if (_name.isEmpty) return;
                            if (_icon == null) return;

                            final _type = selectedCategoryNotifier.value;
                            final _category = CategoryModel(
                                id: DateTime.now()
                                    .microsecondsSinceEpoch
                                    .toString(),
                                name: _name,
                                type: _type,
                                categoryIcon: _icon!);

                            CategoryDB.instance.insertCategory(_category);

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
