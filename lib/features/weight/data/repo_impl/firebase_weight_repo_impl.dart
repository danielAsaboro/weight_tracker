import 'package:weight_tracker/core/constants/enums.dart';
import 'package:weight_tracker/core/types/type.dart';
import 'package:weight_tracker/features/weight/domain/entities/weight.dart';
import 'package:weight_tracker/features/weight/domain/repo/weight_repo.dart';

import '../../../../core/storage/db.dart';

class WeightRepoFireBaseImpl implements WeightRepo {
  final DBStorage<Weight> _firebaseFireStoreDB;

  WeightRepoFireBaseImpl(this._firebaseFireStoreDB);

  @override
  Future<Weight> getThisWeightEntry(String id) async {
    try {
      final result = await _firebaseFireStoreDB.getEntryById(id);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addNewWeightEntry(Weight weight) async {
    try {
      await _firebaseFireStoreDB.createNewEntry(weight);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteThisWeightEntry(String weightEntryId) async {
    try {
      await _firebaseFireStoreDB.deleteThisEntryById(weightEntryId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<Weight>> getAllWeightEntries() {
    try {
      return _firebaseFireStoreDB.getAllEntries();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<Weight>> getAllWeightEntriesBasedOnQuery(OrderBy sortFilter) {
    try {
      return _firebaseFireStoreDB.sortEntriesBy(orderBy: sortFilter, limit: 10);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateThisWeightEntry(
      String weightEntryId, Weight updatedWeight) async {
    try {
      await _firebaseFireStoreDB.updateEntryWithId(
        weightEntryId,
        updatedWeight,
      );
    } catch (e) {
      rethrow;
    }
  }
}
