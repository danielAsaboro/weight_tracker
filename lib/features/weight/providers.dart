import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker/features/weight/domain/repo/weight_repo.dart';
import 'package:weight_tracker/features/weight/domain/usecase/weight_usecase_impl.dart';
import 'package:weight_tracker/features/weight/presentation/controllers/weight_controller.dart';

import '../../core/storage/db.dart';
import '../../core/storage/firestore_db_impl.dart';
import 'data/repo_impl/weight_repo_impl.dart';
import 'domain/entities/weight.dart';
import 'domain/usecase/weight_usecase.dart';

// TODO: clean this stuff
final fireBaseProvider = Provider<DBStorage<Weight>>((ref) {
  return FirebaseFireStoreDB<Weight>(
    "okay",
    "weights",
    fromFireStore: (p0, p1) => Weight(null, 123),
    toMap: (weight) => weight.toJson(),
  );
});

final weightRepoFireBaseProvider = Provider<WeightRepo>((ref) {
  return WeightRepoFireBaseImpl(
    ref.watch(fireBaseProvider),
  );
});

final weightUseCaseProvider = Provider<WeightUseCase>((ref) {
  return WeightUseCaseImpl(ref.watch(weightRepoFireBaseProvider));
});

final weightProvider =
    StreamNotifierProvider<WeightNotifier, List<Weight>>(WeightNotifier.new);
