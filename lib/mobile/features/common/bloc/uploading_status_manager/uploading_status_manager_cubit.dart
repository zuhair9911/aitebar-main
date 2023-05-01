import 'package:aitebar/mobile/features/common/domain/uploading_model/uploading_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

part 'uploading_status_manager_state.dart';

@Injectable()
class UploadingStatusManagerCubit extends Cubit<FileUploadingStatusManagerState> {
  UploadingStatusManagerCubit() : super(const FileUploadingStatusManagerUpdating());

  init(XFile file) {
    emit(FileUploadingStatusManagerUpdating(uploadingFile: UploadingModel(file: file)));
  }

  updateProgress({num? progress, num? total}) {
    emit(state.copyWith(uploadingFile: state.uploadingFile!.copyWith(progress: progress, total: total)));
  }

  void updateUrl({required String url}) {
    emit(state.copyWith(uploadingFile: state.uploadingFile!.copyWith(url: url)));
  }
}
