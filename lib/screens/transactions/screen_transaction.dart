import 'package:flutter/material.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              radius: 50,
              child: Text('12\ndec',
              textAlign: TextAlign.center,)
              ),
            title: Text('1000'),
            subtitle: Text('Travel'),
          ),
        );
      },
      separatorBuilder: (ctx, index) {
        return const SizedBox(
          height: 2,
        );
      },
      itemCount: 10,
    );
  }
}
