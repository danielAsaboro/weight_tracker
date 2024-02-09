import 'package:weight_tracker/features/weight/domain/model/weight.dart';

abstract interface class WeightRepo {
  Future<void> addNewWeightEntry();
  Future<List<Weight>> getAllWeightEntries();
  Future<void> updateThisWeightEntry(int weightEntryId);
  Future<void> deleteThisWeightEntry(int weightEntryId);
}
