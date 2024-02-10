import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weight_tracker/core/storage/db.dart';

import '../types/type.dart';

class FirebaseFireStoreDB<T> implements DBStorage<T> {
  final String userId;
  final String collectionName;
  final CollectionReference collectionReference;
  final T Function(String, Map<String, dynamic>) fromFireStore;
  final Map<String, dynamic> Function(T) toMap;

  FirebaseFireStoreDB(
    this.userId,
    this.collectionName, {
    required this.fromFireStore,
    required this.toMap,
  }) : collectionReference =
            FirebaseFirestore.instance.collection(collectionName);

  @override
  Future<void> createNewEntry(T data) async {
    try {
      print(toMap(data));
      await collectionReference.add(toMap(data));
      // await collectionReference.doc(userId).set(T.toString());
    } catch (e) {
      // Handle error
      print('Error creating new entry: $e');
      rethrow;
    }
  }

  @override
  Future<T> getEntryById(String id) async {
    try {
      final snap = await collectionReference.doc(id).get();
      if (!snap.exists) throw Exception("Document doesn't exist");
      return fromFireStore(snap.id, snap.data()! as Map<String, dynamic>);
    } catch (e) {
      // Handle error
      print('Error updating entry with id $id: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateEntryWithId(String id, T data) async {
    try {
      final result = await collectionReference.doc(id).update(toMap(data));
    } catch (e) {
      // Handle error
      print('Error updating entry with id $id: $e');
      rethrow;
    }
  }

  @override
  Stream<List<T>> getAllEntries() {
    try {
      print("about to get all entries lmao");
      return collectionReference.snapshots().map(
          // (snapshot) => snapshot.docs.map((doc) => doc.data() as T).toList());
          (snapshot) => snapshot.docs.map((doc) {
                print("printing document");
                final json = doc.data() as Map<String, dynamic>;
                print();
                return fromFireStore("df", json);
              }).toList());
    } catch (e) {
      // Handle error
      print('Error getting all entries: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteThisEntryById(String id) async {
    try {
      await collectionReference.doc(id.toString()).delete();
    } catch (e) {
      // Handle error
      print('Error deleting entry with id $id: $e');
      rethrow;
    }
  }

  @override
  Future<List<T>> sortEntriesBy({
    required OrderBy orderBy,
    required int limit,
  }) async {
    try {
      //
      final result = await collectionReference
          .orderBy(orderBy.filter,
              descending: orderBy.direction.inDescendingOrder)
          .get();

      return result.docs.map((doc) => doc.data() as T).toList();
    } catch (e) {
      //
      // Handle error
      print('Error getting stuff through query: $e');
      rethrow;
    }
  }
}
