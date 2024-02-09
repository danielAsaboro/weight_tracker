abstract interface class DBStorage {
  Future<void> createNewEntry();
  Future<List<void>> getAllEntries();
  Future<void> updateThisEntryById(int id);
  Future<void> deleteThisEntryById(int id);
}
