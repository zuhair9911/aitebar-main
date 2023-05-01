import 'package:aitebar/core/services/local_storage/secure_storage_service.dart';
import 'package:aitebar/core/services/local_storage/storage_facade.dart';
import 'package:injectable/injectable.dart';

@module
abstract class InjectableModule {
  @Injectable(as: IStorageFacade)
  SecureStorageService get hive => SecureStorageService();
}
