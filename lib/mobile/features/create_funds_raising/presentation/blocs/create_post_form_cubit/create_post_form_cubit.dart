import 'package:aitebar/core/services/picker/file_picker.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/mobile/features/create_funds_raising/domain/models/funds_raising/funds_raising.dart';
import 'package:aitebar/mobile/features/common/bloc/uploading_status_manager/uploading_status_manager_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

part 'create_post_form_state.dart';

@Injectable()
class CreatePostFormCubit extends Cubit<CreatePostFormState> {
  CreatePostFormCubit() : super(CreatePostFormUpdate());

  void setAutovalidateMode(AutovalidateMode value) {
    emit(state.copyWith(autovalidateMode: value));
  }

  void onChangedTitle(String value) {
    emit(state.copyWith(fundsRaising: state.fundsRaising.copyWith(title: value)));
  }

  void onChangedDescription(String value) {
    emit(state.copyWith(fundsRaising: state.fundsRaising.copyWith(description: value)));
  }

  void onChangedRequireAmount(String value) {
    emit(state.copyWith(fundsRaising: state.fundsRaising.copyWith(requireAmount: num.tryParse(value) ?? 0)));
  }

  void onChangedAddress(String value) {
    emit(state.copyWith(fundsRaising: state.fundsRaising.copyWith(address: value)));
  }

  void onChangedContactNumber(String value) {
    emit(state.copyWith(fundsRaising: state.fundsRaising.copyWith(contactNumber: value)));
  }

  void onChangedCategory(String value) {
    emit(state.copyWith(fundsRaising: state.fundsRaising.copyWith(category: value)));
  }

  void onChangedEmail(String email) {
    emit(state.copyWith(fundsRaising: state.fundsRaising.copyWith(email: email)));
  }

  void onChangedAccountTitle(String value) {
    emit(state.copyWith(fundsRaising: state.fundsRaising.copyWith(accountTitle: value)));
  }

  void onChangedBankName(String value) {
    emit(state.copyWith(fundsRaising: state.fundsRaising.copyWith(bankName: value)));
  }

  void onChangedAccountNumber(String value) {
    emit(state.copyWith(fundsRaising: state.fundsRaising.copyWith(accountNumber: value)));
  }

  void pickImages() async {
    FilePicker filePicker = FilePicker();
    var data = await filePicker.pickImages();
    if (data is List<XFile>) {
      List<UploadingStatusManagerCubit> cubits = [];
      for (int i = 0; i < data.length; i++) {
        cubits.add(sl<UploadingStatusManagerCubit>()..init(data[i]));
      }
      emit(state.copyWith(uploadingManager: [...cubits]));
    }
  }

  void onRemoveFile(XFile file) {
    List<UploadingStatusManagerCubit>? uploader = state.uploadingManager;
    uploader?.removeWhere((element) => element.state.uploadingFile?.file == file);
    emit(state.copyWith(uploadingManager: [...?uploader]));
  }

  void onRemoveImageUrl(String url) {
    List<String> images = [...state.fundsRaising.images];
    images.removeWhere((element) => element == url);
    emit(state.copyWith(fundsRaising: state.fundsRaising.copyWith(images: [...images])));
  }

  void reset() {
    emit(CreatePostFormUpdate());
  }

  void onChangedAmount(value) {
    emit(state.copyWith(fundsRaising: state.fundsRaising.copyWith(requireAmount: value)));
  }

  void init(FundsRaising fundsRaising) {
    emit(state.copyWith(fundsRaising: fundsRaising));
  }
}
