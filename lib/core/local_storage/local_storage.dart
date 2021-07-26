import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/foundation.dart' show kIsWeb;

abstract class LocalStorage {
  Future<void> init();
  Future<void> saveData({required String key, required String value});
  Future<String> getData({required String key});
  Future<void> deleteData({required String key});
  Future<List<dynamic>> getAllData();
}

class LocalStorageImpl implements LocalStorage {
  final String boxName;

  LocalStorageImpl({required this.boxName});
  @override
  Future<void> init() async {
    if (kIsWeb) {
      print('Platform is web');
    } else {
      final appDocumentDir =
          await path_provider.getApplicationDocumentsDirectory();
      Hive.init(appDocumentDir.path);
    }
    await Hive.openBox(boxName);
  }

  @override
  Future<String> getData({required String key}) async {
    return Hive.box(boxName).get(key);
  }

  @override
  Future<void> deleteData({required String key}) async {
    await Hive.box(boxName).delete(key);
  }

  @override
  Future<void> saveData({required String key, required String value}) async {
    await Hive.box(boxName).put(key, value);
  }

  @override
  Future<List<dynamic>> getAllData() async {
    final box = Hive.box(boxName);
    return box.values.toList();
  }
}
