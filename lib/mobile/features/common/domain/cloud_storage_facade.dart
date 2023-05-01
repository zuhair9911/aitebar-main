
import 'package:image_picker/image_picker.dart';

abstract class ICloudStorageFacade<T> {
  Future<T> uploadFile({String path, required XFile file, Function(num progress, num total)? uploadingProgress});
}