import 'dart:io';

import 'package:aitebar/core/constants/firebase_key.dart';
import 'package:aitebar/core/logging/logger.dart';
import 'package:aitebar/mobile/features/common/domain/cloud_storage_facade.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ICloudStorageFacade)
class FirebaseStorageService extends ICloudStorageFacade {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final _log = getLogger('FirebaseStorageService');

  @override
  Future uploadFile({String path = FirebaseKey.images, required XFile file, Function(num progress, num total)? uploadingProgress}) async {
    try {
      String name = DateTime.now().toString() + file.name;
      Reference reference = _firebaseStorage.ref(path).child(name);
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path},
      );
      UploadTask task;
      if (kIsWeb) {
        task = reference.putData(await file.readAsBytes(), metadata);
      } else {
        task = reference.putFile(File(file.path), metadata);
      }
      task.snapshotEvents.listen((TaskSnapshot snapshot) {
        _log.d('FirebaseStorageService.uploadFile: ${snapshot.bytesTransferred} ${snapshot.totalBytes}');
        uploadingProgress?.call(snapshot.bytesTransferred, snapshot.totalBytes);
      });

      TaskSnapshot taskSnapshot = await task.whenComplete(() => {_log.d('Task completed')});
      return taskSnapshot.ref.getDownloadURL();
    } on FirebaseException catch (e, stackTrace) {
      _log.e('FirebaseException $e $stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      _log.e('catch $e $stackTrace');
      rethrow;
    }
  }
}
