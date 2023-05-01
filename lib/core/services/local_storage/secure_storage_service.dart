import 'package:aitebar/core/services/local_storage/storage_facade.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService extends IStorageFacade {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  Future<dynamic> read(String key) async {
    return await _storage.read(key: key);
  }

  @override
  Future<void> write(String key, value) async {
    await _storage.write(key: key, value: value);
  }

  @override
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  @override
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
