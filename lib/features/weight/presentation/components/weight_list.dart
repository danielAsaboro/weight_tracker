import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker/features/weight/presentation/components/input_alert.dart';
import 'package:weight_tracker/features/weight/providers.dart';


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
                  return ListView.builder(
                    itemCount: weights.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text("$index"),
                        ),
                      );
                    },
                  );
                },
                error: (object, stackTrace) => Text(stackTrace.toString()),
                loading: () => const CircularProgressIndicator(),
              );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await getWeight(context, "Add Your Weight");
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
}
