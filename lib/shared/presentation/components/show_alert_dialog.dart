import 'package:flutter/material.dart';

import 'app_button.dart';

Future<bool> showBooleanAlertDialog(
  BuildContext context,
  String message,
  String rejectText,
  String acceptText,
) async {
  final response = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: <Widget>[
            AppButton(
              child: Text(
                rejectText,
                style: const TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            AppButton(
              child: Text(
                acceptText,
                style: const TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      });

  return response!;
}
