import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker/features/weight/providers.dart';

import '../../domain/entities/weight.dart';

class WeightNotifier extends StreamNotifier<List<Weight>> {
  @override
  Stream<List<Weight>> build() async* {
    final weightController = StreamController<List<Weight>>();
    ref.read(weightUseCaseProvider).getAllWeightEntries().listen((event) {
      weightController.add(event);
    });
    yield* weightController.stream;
  }

  Future<void> addNewWeight(Weight weight) async {
    ref.read(weightUseCaseProvider).createNewWeightEntry(weight);
  }

  Future<void> updateThisWeight(
    int index,
  ) async {}
  Future<void> deleteThisWeight(
    int index,
  ) async {}
}
