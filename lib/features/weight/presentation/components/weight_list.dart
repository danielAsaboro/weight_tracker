import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker/features/weight/presentation/components/input_alert.dart';
import 'package:weight_tracker/features/weight/providers.dart';
import 'package:weight_tracker/shared/presentation/components/app_button.dart';
import 'package:weight_tracker/shared/presentation/components/bottom_sheet.dart';

class WeightListScreen extends ConsumerStatefulWidget {
  const WeightListScreen({super.key});

  @override
  ConsumerState<WeightListScreen> createState() => _WeightListScreenState();
}

class _WeightListScreenState extends ConsumerState<WeightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weights DashBoard"),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          return ref.watch(weightProvider).when(
                data: (weights) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    // TODO: Dismissible to delete
                    child: ListView.builder(
                      itemCount: weights.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            try {
                              final result = await showUpdateBottomSheet(
                                context,
                                index,
                              );
                              print(result);
                            } catch (e) {
                              //
                            }
                          },
                          child: Dismissible(
                            key: Key(index.toString()),
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.endToStart) {
                                final bool? res = await showDialog<bool>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Text(
                                            "Are you sure you want to delete ${[
                                          index
                                        ]}?"),
                                        actions: <Widget>[
                                          AppButton(
                                            child: const Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          AppButton(
                                            child: const Text(
                                              "Delete",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            onPressed: () {
                                              // TODO: Delete the item from DB etc..
                                              setState(() {
                                                // itemsList.removeAt(index);
                                                // TODO
                                              });
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                                return res;
                              } else {
                                // Navigate to Edit Page;
                                try {
                                  final result = await showUpdateBottomSheet(
                                    context,
                                    index,
                                  );
                                  print(result);
                                } catch (e) {
                                  //TODO
                                }
                              }
                            },
                            background: slideRightBackground(),
                            secondaryBackground: slideLeftBackground(),
                            child: Card(
                              child: ListTile(
                                leading: const Icon(Icons.run_circle_outlined),
                                title: Text(weights[index].foodEaten ?? ""),
                                subtitle: Text(
                                    weights[index].timeAdded.toIso8601String()),
                                trailing: Text(weights[index].value.toString()),
                                // TODO, format that date properly
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                error: (object, stackTrace) => Text(stackTrace.toString()),
                loading: () => const CircularProgressIndicator(),
              );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result =
              await getWeightFromAlertBox(context, "Add Your Weight");
          if (result != null) {
            await ref.read(weightProvider.notifier).addNewWeight(result);
            print(result.value);
          } else {
//TODO
            print(result);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            Text(
              " Edit",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: const Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
