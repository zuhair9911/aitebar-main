import 'dart:io';

import 'package:aitebar/core/services/picker/file_picker_facade.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FilePicker extends FilePickerFacade {
  @override
  Future<dynamic> pickImage({ImageSource imageSource = ImageSource.gallery}) async {
    try {
      ImagePicker imagePicker = ImagePicker();
      return imagePicker.pickImage(source: imageSource);
    } on PlatformException catch (e) {
      debugPrint('FilePicker.pickImage: $e');
    } catch (e) {
      debugPrint('FilePicker.pickImage: $e');
    }
  }

  @override
  Future<dynamic> pickImages() async {
    try {
      ImagePicker imagePicker = ImagePicker();
      return imagePicker.pickMultiImage(imageQuality: 50);
    } on PlatformException catch (e) {
      debugPrint('FilePicker.pickImage: $e');
    } catch (e) {
      debugPrint('FilePicker.pickImage: $e');
    }
  }

  @override
  Future<File?> pickVideo({ImageSource imageSource = ImageSource.gallery}) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickVideo(source: imageSource);
    if (xFile != null) {
      return File(xFile.path);
    }
    return null;
  }
}
