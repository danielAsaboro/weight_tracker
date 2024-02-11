import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker/features/weight/providers.dart';

import '../../../auth/providers.dart';
import '../../domain/entities/weight.dart';

class WeightNotifier extends StreamNotifier<List<Weight>> {
  @override
  Stream<List<Weight>> build() {
    final weightController = StreamController<List<Weight>>();
    ref.read(weightUseCaseProvider).getAllWeightEntries().listen((event) {
      weightController.add(event);
    });
    return weightController.stream;
  }

  Future<void> addNewWeight(double weightValue) async {
    try {
      final userDetails = ref.read(authUseCaseProvider).user;
      final weight = Weight(
        userId: userDetails.userId,
        value: weightValue,
      );
      await ref.read(weightUseCaseProvider).createNewWeightEntry(weight);
    } catch (e) {
      // TODO: check this out;
      print(e.toString());
      rethrow;
    }
  }

  Future<void> updateThisWeight(
    int index,
    Weight updatedWeight,
  ) async {
    try {
      await ref
          .read(weightUseCaseProvider)
          .updateThisWeightEntryWithId(updatedWeight.id!, updatedWeight);
    } catch (e) {
      // TODO: check this out;
      print(e.toString());
      rethrow;
    }
  }

  Future<void> deleteThisWeight(
    int index,
  ) async {
    try {
      final retrievedWeight = (state.requireValue)[index];
      await ref
          .read(weightUseCaseProvider)
          .deleteWeightEntryWithId(retrievedWeight.id!);
    } catch (e) {
      // TODO: check this out;
      print(e.toString());
      rethrow;
    }
  }
}
