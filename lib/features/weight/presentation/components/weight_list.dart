import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker/core/types/type.dart';
import 'package:weight_tracker/features/weight/presentation/components/input_alert.dart';
import 'package:weight_tracker/features/weight/presentation/components/slide_left_background.dart';
import 'package:weight_tracker/features/weight/presentation/components/slide_right_background.dart';
import 'package:weight_tracker/features/weight/providers.dart';
import 'package:weight_tracker/shared/presentation/components/bottom_sheet.dart';

import '../../../../core/constants/enums.dart';
import '../../../../shared/presentation/components/show_alert_dialog.dart';

class WeightListScreen extends ConsumerStatefulWidget {
  const WeightListScreen({super.key});

  @override
  ConsumerState<WeightListScreen> createState() => _WeightListScreenState();
}

class _WeightListScreenState extends ConsumerState<WeightListScreen> {
  OrderBy? selectedSortFilter;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weight DashBoard"),
        actions: [
          Row(
            children: [
              const Text("Sort By:"),
              const SizedBox(
                width: 20,
              ),
              DropdownButton(
                value: selectedSortFilter,
                underline: const SizedBox.shrink(),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                icon: const Icon(Icons.keyboard_arrow_down),
                items: OrderBy.values.map((e) {
                  return DropdownMenuItem<OrderBy>(
                    value: e,
                    child: Text(e.name),
                  );
                }).toList(),
                onChanged: (value) async {
                  setState(() {
                    selectedSortFilter = value;
                  });
                  await ref.read(weightProvider.notifier).sortByQuery(value!);
                },
              ),
            ],
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, _) {
          return ref.watch(weightProvider).when(
                data: (weights) {
                  return weights.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: weights.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  await showUpdateBottomSheet(
                                    context,
                                    index,
                                  );
                                },
                                child: Dismissible(
                                  key: Key(weights[index]
                                      .timeAdded
                                      .toIso8601String()),
                                  confirmDismiss: (direction) async {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      // Ask if to Delete
                                      final bool userResponse =
                                          await showBooleanAlertDialog(
                                        context,
                                        "Are you sure you want to delete record for ${weights[index].timeAdded} ?",
                                        "Cancel",
                                        "Delete",
                                      );
                                      return userResponse;
                                    } else {
                                      // Navigate to Edit Page;
                                      await showUpdateBottomSheet(
                                        context,
                                        index,
                                      );
                                      return false;
                                    }
                                  },
                                  onDismissed: (direction) async {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      await ref
                                          .read(weightProvider.notifier)
                                          .deleteThisWeight(index);
                                    }
                                  },
                                  background:
                                      const DismissibleSlideRightBackground(),
                                  secondaryBackground:
                                      const DismissibleSlideLeftBackground(),
                                  child: Card(
                                    child: ListTile(
                                      leading:
                                          const Icon(Icons.run_circle_outlined),
                                      title:
                                          Text(weights[index].foodEaten ?? ""),
                                      subtitle: Text(weights[index]
                                          .timeAdded
                                          .toIso8601String()),
                                      trailing:
                                          Text(weights[index].value.toString()),
                                      // TODO, format the date properly
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                              "There are no Weights Records for now, add one with the + Icon"),
                        );
                },
                error: (object, stackTrace) => Text(stackTrace.toString()),
                loading: () => const Center(child: CircularProgressIndicator()),
              );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result =
              await getWeightFromAlertBox(context, "Add Your Weight");
          if (result != null) {
            await ref.read(weightProvider.notifier).addNewWeight(result);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
