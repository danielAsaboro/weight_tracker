import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker/features/weight/domain/entities/weight.dart';
import 'package:weight_tracker/features/weight/providers.dart';
import 'package:weight_tracker/shared/presentation/components/app_button.dart';
import 'package:weight_tracker/shared/presentation/components/app_textfield.dart';


Future<Weight?> showUpdateBottomSheet(
  BuildContext context,
  int index,
) async {
  GlobalKey<FormState> formKey = GlobalKey();
  final detailsController = TextEditingController();
  return showModalBottomSheet<Weight?>(
      context: context,
      builder: (context) {
        return Consumer(
          builder: (context, ref, child) {
            final retrievedWeight =
                (ref.read(weightProvider).requireValue)[index];
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.run_circle_outlined),
                      title: Text(retrievedWeight.value.toString()),

                      subtitle:
                          Text(retrievedWeight.timeAdded.toIso8601String()),
                      // TODO, format that date properly
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 340,
                    child: Form(
                      key: formKey,
                      child: AppTextField(
                        detailsController,
                        validator: (result) => null,
                        hintText: "Add what you ate today...",
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                  AppButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final updatedWeightDetails = retrievedWeight.copyWith(
                            foodEaten: detailsController.text);
                        await ref
                            .read(weightProvider.notifier)
                            .updateThisWeight(index, updatedWeightDetails);
                        Navigator.of(context).pop(updatedWeightDetails);
                        // TODO
                      } else {
                        // TODO
                        print("error");
                      }
                      // TODO
                      Navigator.of(context).pop(
                          // TODO
                          );
                    },
                    child: const Text("Update Details"),
                  )
                ],
              ),
            );
          },
        );
      });
}
