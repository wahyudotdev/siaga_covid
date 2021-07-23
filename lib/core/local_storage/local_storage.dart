import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

abstract class LocalStorage {
  Future<void> call();
  Future<void> saveData({required String key, required String value});
  Future<String> getData({required String key});
  Future<void> deleteData({required String key});
}

const COVID_STATISTICS_BOX = 'covid_statistics';

class LocalStorageImpl implements LocalStorage {
  @override
  Future<void> call() async {
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    await Hive.openBox(COVID_STATISTICS_BOX);
  }

  @override
  Future<String> getData({required String key}) async {
    return Hive.box(COVID_STATISTICS_BOX).get(key);
  }

  @override
  Future<void> deleteData({required String key}) async {
    await Hive.box(COVID_STATISTICS_BOX).delete(key);
  }

  @override
  Future<void> saveData({required String key, required String value}) async {
    await Hive.box(COVID_STATISTICS_BOX).put(key, value);
  }
}
