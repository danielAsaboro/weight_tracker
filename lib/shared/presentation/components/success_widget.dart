import 'package:flutter/material.dart';

class SuccessAlertWidget extends StatelessWidget {
  const SuccessAlertWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 340,
        height: 70,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: const Card(
          child: ListTile(
            leading: Icon(Icons.check),
            title: Text("Successful!"),
            trailing: Icon(Icons.cancel),
          ),
        ),
      ),
    );
  }
}
