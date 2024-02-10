import 'package:weight_tracker/features/weight/domain/repo/weight_repo.dart';

import '../entities/weight.dart';
import 'weight_usecase.dart';

class WeightUseCaseImpl implements WeightUseCase {
  final WeightRepo _weightRepo;
  WeightUseCaseImpl(this._weightRepo);

  @override
  Future createNewWeightEntry(Weight weight) async {
    try {
      await _weightRepo.addNewWeightEntry(weight);
      // TODO
    } catch (e) {
      //
      rethrow;
    }
  }

  @override
  Future deleteWeightEntryWithId(String id) async {
    try {
      await _weightRepo.deleteThisWeightEntry(id);
      // TODO
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<Weight>> getAllWeightEntries() {
    try {
      return _weightRepo.getAllWeightEntries();
      //
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Weight> getWeightEntryWithThisId(String id) async {
    try {
      return await _weightRepo.getThisWeightEntry(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateThisWeightEntryWithId(String id, Weight updatedWeight) async {
    try {
      return await _weightRepo.updateThisWeightEntry(id, updatedWeight);
    } catch (e) {
      rethrow;
    }
  }
}
