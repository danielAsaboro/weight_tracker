import '../constants/enums.dart';

abstract interface class DBStorage<T> {
  Future<void> createNewEntry(T data);
  Future<T> getEntryById(String id);
  // Future not necessary for a REST API
  // as a Future is just a single-event Stream
  Future<void> updateEntryWithId(String id, T data);
  Future<void> deleteThisEntryById(String id);
  Stream<List<T>> getAllEntries(
    String userId,
  );
  Stream<List<T>> sortEntriesBy({
    required OrderBy orderBy,
    required int limit,
    required String userId,
  });
}
