import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weight_tracker/core/storage/db.dart';

import '../constants/enums.dart';
import '../types/type.dart';

class FirebaseFireStoreDB<T> implements DBStorage<T> {
  final String collectionName;
  final CollectionReference collectionReference;
  final T Function(String, Map<String, dynamic>) fromFireStore;
  final Map<String, dynamic> Function(T) toMap;

  QueryDocumentSnapshot? startAfterDocument;

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
      print('Error updating entry with id $id: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateEntryWithId(String id, T data) async {
    try {
      await collectionReference.doc(id).update(toMap(data));
    } catch (e) {
      print('Error updating entry with id $id: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteThisEntryById(String id) async {
    try {
      await collectionReference.doc(id.toString()).delete();
    } catch (e) {
      print('Error deleting entry with id $id: $e');
      rethrow;
    }
  }

  @override
  Stream<List<T>> getAllEntries(String userId) {
    try {
      Query query =
          collectionReference.where("userId", isEqualTo: userId).limit(2);
      return query.snapshots().map((snapshot) => snapshot.docs
          .map((doc) =>
              fromFireStore(doc.id, doc.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      print('Error getting all entries: $e');
      rethrow;
    }
  }

  @override
  Stream<List<T>> sortEntriesBy({
    required OrderBy orderBy,
    required PageNumber pageNumber,
    required String userId,
  }) {
    try {
      Query query = collectionReference
          .where("userId", isEqualTo: userId)
          .orderBy(
            orderBy.filter,
            descending: orderBy.inDescendingOrder,
          )
          .limit(2);
      if (startAfterDocument != null) {
        query = query.startAfterDocument(startAfterDocument!);
      }
      query
          .snapshots()
          .map((snapshot) => snapshot.docs.toList())
          .last
          .then((value) {
        print("printing query snapshot");
        print(value);
        startAfterDocument = value.last;
      });
      return query.snapshots().map((snapshot) => snapshot.docs
          .map((doc) =>
              fromFireStore(doc.id, doc.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      print('Error getting sorted entries: $e');
      rethrow;
    }
  }

// Testing for Pagination.
  // Future<List<T>> sortEntriesByFuture({
  //   required OrderBy orderBy,
  //   required PageNumber pageNumber,
  //   required String userId,
  // }) {
  //   Query query = collectionReference
  //       .where("userId", isEqualTo: userId)
  //       .orderBy(
  //         orderBy.filter,
  //         descending: orderBy.inDescendingOrder,
  //       )
  //       .limit(2);

  //   return query.get().then(
  //     (documentSnapshots) {
  //       final lastVisible = documentSnapshots.docs[documentSnapshots.size - 1];

  //       // Construct a new query starting at this document,
  //       // get the next 25 cities.
  //       final next = collectionReference
  //           .where("userId", isEqualTo: userId)
  //           .orderBy(
  //             orderBy.filter,
  //             descending: orderBy.inDescendingOrder,
  //           )
  //           .startAfterDocument(lastVisible)
  //           .limit(25);

  //       return next.get().then((value) => value.docs
  //           .map((doc) =>
  //               fromFireStore(doc.id, doc.data() as Map<String, dynamic>))
  //           .toList());
  //     },
  //     onError: (e) => print("Error completing: $e"),
  //   );
  // }
}
