import 'package:weight_tracker/features/weight/domain/entities/weight.dart';

abstract interface class WeightRepo {
  Future<void> addNewWeightEntry(Weight weight);
  Future<Weight> getThisWeightEntry(String id);
  Stream<List<Weight>> getAllWeightEntries();
  Future<void> updateThisWeightEntry(
    String weightEntryId,
    Weight updatedWeight,
  );
  Future<void> deleteThisWeightEntry(String weightEntryId);
}
