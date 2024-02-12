import '../../../../core/constants/enums.dart';
import '../../../../core/types/type.dart';
import '../entities/weight.dart';

abstract class WeightUseCase {
  Future<void> createNewWeightEntry(Weight weight);
  Future<Weight> getWeightEntryWithThisId(String id);
  Future<void> updateThisWeightEntryWithId(String id, Weight updatedWeight);
  Future<void> deleteWeightEntryWithId(String id);
  Stream<List<Weight>> getAllWeightEntries(String userId);
  Stream<List<Weight>> getAllWeightEntriesByQuery(
    OrderBy sortFilter,
    PageNumber pageNumber,
    String userId,
  );
}
