import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../types/type.dart';

abstract class LocalStorage {
  //
  Future<void> saveToLocalStorage(String key, String value);

  Future<void> updateDataWithThisKey(String key, String value);

  Future<Json?> readDataWithThisKey(String key);

  Future<bool> deleteDataWithThisKey(String key);

  Future<bool> deleteAllData();
}

class LocalStorageWithSharedPref implements LocalStorage {
  LocalStorageWithSharedPref();

  @override
  Future<void> saveToLocalStorage(
    String key,
    String value,
  ) async {
    try {
      final sharedPref = await SharedPreferences.getInstance();

      await sharedPref.setString(key, value);
    } catch (e) {
      print(e.toString());
      throw Exception("Failed to save data: $key");
    }
  }

  @override
  Future<Json?> readDataWithThisKey(String key) async {
    try {
      final sharedPref = await SharedPreferences.getInstance();

      final result = sharedPref.getString(key);
      if (result != null) return jsonDecode(result);
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateDataWithThisKey(String key, String value) async {
    await saveToLocalStorage(key, value);
  }

  @override
  Future<bool> deleteDataWithThisKey(String key) async {
    try {
      print("deleting data");
      final sharedPref = await SharedPreferences.getInstance();
      final isDataCleared = await sharedPref.remove(key);
      return isDataCleared ? true : false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteAllData() async {
    try {
      print("deleting all data");
      final sharedPref = await SharedPreferences.getInstance();
      final isAllDataCleared = await sharedPref.clear();
      print("deleted all data: $isAllDataCleared");
      return isAllDataCleared ? true : false;
    } catch (e) {
      return false;
    }
  }
}

final sharedPrefProvider = Provider<LocalStorageWithSharedPref>((ref) {
  return LocalStorageWithSharedPref();
});
