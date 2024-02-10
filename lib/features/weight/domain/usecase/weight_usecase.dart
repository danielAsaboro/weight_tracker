import '../entities/weight.dart';

abstract class WeightUseCase {
  Future<void> createNewWeightEntry(Weight weight);
  Stream<List<Weight>> getAllWeightEntries();
  Future<Weight> getWeightEntryWithThisId(String id);
  Future<void> updateThisWeightEntryWithId(String id, Weight updatedWeight);
  Future<void> deleteWeightEntryWithId(String id);
}
