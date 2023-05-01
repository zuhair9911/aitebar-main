import 'dart:io';

abstract class FilePickerFacade {
  Future<dynamic> pickImages();

  Future<dynamic> pickImage();

  Future<File?> pickVideo();
}
