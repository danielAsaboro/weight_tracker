import 'package:weight_tracker/features/weight/domain/entities/weight.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/types/type.dart';

abstract interface class WeightRepo {
  Future<void> addNewWeightEntry(Weight weight);
  Future<Weight> getThisWeightEntry(String id);
  Future<void> updateThisWeightEntry(
    String weightEntryId,
    Weight updatedWeight,
  );
  Future<void> deleteThisWeightEntry(String weightEntryId);
  Stream<List<Weight>> getAllWeightEntries(String userId);
  Stream<List<Weight>> getAllWeightEntriesBasedOnQuery(
    OrderBy sortFilter,
    PageNumber pageNumber,
    String userId,
  );
}
