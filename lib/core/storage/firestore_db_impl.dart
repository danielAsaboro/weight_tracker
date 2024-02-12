import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weight_tracker/core/storage/db.dart';

import '../constants/enums.dart';

class FirebaseFireStoreDB<T> implements DBStorage<T> {
  final String collectionName;
  final CollectionReference collectionReference;
  final T Function(String, Map<String, dynamic>) fromFireStore;
  final Map<String, dynamic> Function(T) toMap;

  FirebaseFireStoreDB(
    this.collectionName, {
    required this.fromFireStore,
    required this.toMap,
  }) : collectionReference =
            FirebaseFirestore.instance.collection(collectionName);

  @override
  Future<void> createNewEntry(T data) async {
    try {
      await collectionReference.add(toMap(data));
    } catch (e) {
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
      await collectionReference.doc(id).update(toMap(data));
    } catch (e) {
      // Handle error
      print('Error updating entry with id $id: $e');
      rethrow;
    }
  }

  @override
  Stream<List<T>> getAllEntries(
    String userId,
  ) {
    try {
      return collectionReference
          .where("userId", isEqualTo: userId) 
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) =>
                  fromFireStore(doc.id, doc.data() as Map<String, dynamic>))
              .toList());
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
  Stream<List<T>> sortEntriesBy({
    required OrderBy orderBy,
    required int limit,
    required String userId,
  }) {
    try {
      final orderResult = collectionReference
          .where("userId", isEqualTo: userId)
          .orderBy(
            orderBy.filter,
            descending: orderBy.inDescendingOrder,
          )
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs);

      return orderResult.map((docSnapshot) => docSnapshot
          .map((doc) =>
              fromFireStore(doc.id, doc.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      //
      // Handle error
      print('Error getting stuff through query: $e');
      rethrow;
    }
  }
}
