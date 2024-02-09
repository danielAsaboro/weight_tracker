import 'package:flutter/material.dart';

class ErrorAlertWidget extends StatelessWidget {
  const ErrorAlertWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 84,
        width: 340,
        decoration: const BoxDecoration(),
        child: const Card(
          child: ListTile(
            leading: Icon(Icons.warning_amber_rounded),
            title: Text("Something Went Wrong!"),
            subtitle: Text("Please try again or send report"),
            trailing: Icon(Icons.cancel),
          ),
        ));
  }
}
