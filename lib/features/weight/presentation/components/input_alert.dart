import 'package:flutter/material.dart';
import 'package:weight_tracker/shared/presentation/components/app_button.dart';
import 'package:weight_tracker/shared/presentation/components/app_textfield.dart';

class AppValidators {
  static String? checkIfContainsNumberOnly(String? text) {
    try {
      double.parse(text!);
      return null;
    } on FormatException {
      return "$text is not a valid weight";
    }
  }
}

Future<double?> getWeightFromAlertBox(
  BuildContext context,
  String title,
) async {
  GlobalKey<FormState> formKey = GlobalKey();

  final weightTextController = TextEditingController();
  return showDialog<double?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: formKey,
                child: AppTextField(
                  weightTextController,
                  validator: AppValidators.checkIfContainsNumberOnly,
                  hintText: "Enter your Weights...",
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          actions: [
            AppButton(
              onPressed: () {
                Navigator.pop(context);
              },
              outlined: true,
              child: const Text("Cancel"),
            ),
            AppButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final weight = double.parse(weightTextController.text);
                  Navigator.of(context).pop(weight);
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      });
}
