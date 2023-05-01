part of 'uploading_status_manager_cubit.dart';

@immutable
abstract class FileUploadingStatusManagerState {
  final UploadingModel? uploadingFile;

  const FileUploadingStatusManagerState({this.uploadingFile});

  FileUploadingStatusManagerState copyWith({UploadingModel? uploadingFile});
}

class FileUploadingStatusManagerUpdating extends FileUploadingStatusManagerState {
  const FileUploadingStatusManagerUpdating({UploadingModel? uploadingFile}) : super(uploadingFile: uploadingFile);

  @override
  FileUploadingStatusManagerState copyWith({UploadingModel? uploadingFile}) {
    return FileUploadingStatusManagerUpdating(uploadingFile: uploadingFile ?? this.uploadingFile);
  }
}
