abstract class IStorageFacade {

  Future<dynamic> read(String key);

  void write(String key, dynamic value);

  void delete(String key);

  void clearAll();
}
