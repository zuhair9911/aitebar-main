import 'package:aitebar/core/services/picker/file_picker.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/mobile/features/common/bloc/uploading_status_manager/uploading_status_manager_cubit.dart';
import 'package:aitebar/mobile/features/create_funds_request/domain/models/request_fund/funds_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

part 'request_fund_form_state.dart';

@Injectable()
class RequestFundFormCubit extends Cubit<RequestFundFormState> {
  RequestFundFormCubit() : super(const RequestFundFormUpdate());

  init({FundsRequest? requestFund}) {
    if (requestFund != null) {
      emit(RequestFundFormUpdate(requestFund: requestFund, autovalidateMode: AutovalidateMode.disabled));
    }
  }

  void setAutovalidateMode(AutovalidateMode value) {
    emit(state.copyWith(autovalidateMode: value));
  }

  void onChangedTitle(String value) {
    emit(state.copyWith(requestFund: state.requestFund.copyWith(title: value)));
  }

  void onChangedDescription(String value) {
    emit(state.copyWith(requestFund: state.requestFund.copyWith(description: value)));
  }

  void onChangedRequestedAmount(String value) {
    emit(state.copyWith(requestFund: state.requestFund.copyWith(requestedAmount: num.tryParse(value) ?? 0)));
  }

  void onChangedCategory(String value) {
    emit(state.copyWith(requestFund: state.requestFund.copyWith(category: value)));
  }

  void onChangedAccountTitle(String value) {
    emit(state.copyWith(requestFund: state.requestFund.copyWith(accountTitle: value)));
  }

  void onChangedBankName(String value) {
    emit(state.copyWith(requestFund: state.requestFund.copyWith(bankName: value)));
  }

  void onChangedAccountNumber(String value) {
    emit(state.copyWith(requestFund: state.requestFund.copyWith(accountNumber: value)));
  }

  void onChangedZakatEligible(bool? value) {
    emit(state.copyWith(requestFund: state.requestFund.copyWith(isZakatEligible: value)));
  }

  void pickCnicImages() async {
    FilePicker filePicker = FilePicker();
    var data = await filePicker.pickImages();
    if (data is List<XFile>) {
      List<UploadingStatusManagerCubit> cubits = [];
      for (int i = 0; i < data.length; i++) {
        cubits.add(sl<UploadingStatusManagerCubit>()..init(data[i]));
      }
      emit(state.copyWith(cnicUploadingManager: [...cubits.take(2)]));
    }
  }

  void onRemoveCNICImage(XFile file) {
    List<UploadingStatusManagerCubit>? uploader = state.cnicUploadingManager;
    uploader?.removeWhere((element) => element.state.uploadingFile?.file == file);
    emit(state.copyWith(cnicUploadingManager: [...?uploader]));
  }

  void onRemoveCNICImageUrl(String url) {
    List<String> images = [...state.requestFund.cnicImages];
    images.removeWhere((element) => element == url);
    emit(state.copyWith(requestFund: state.requestFund.copyWith(cnicImages: [...images])));
  }

  void pickBillImages() async {
    FilePicker filePicker = FilePicker();
    var data = await filePicker.pickImages();
    if (data is List<XFile>) {
      List<UploadingStatusManagerCubit> cubits = [];
      for (int i = 0; i < data.length; i++) {
        cubits.add(sl<UploadingStatusManagerCubit>()..init(data[i]));
      }
      emit(state.copyWith(billUploadingManager: [...cubits.take(2)]));
    }
  }

  void onRemoveBillImage(XFile file) {
    List<UploadingStatusManagerCubit>? uploader = [...?state.billUploadingManager];
    uploader.removeWhere((element) => element.state.uploadingFile?.file == file);
    emit(state.copyWith(billUploadingManager: [...uploader]));
  }

  void onRemoveBillImageUrl(String url) {
    List<String> images = [...state.requestFund.cnicImages];
    images.removeWhere((element) => element == url);
    emit(state.copyWith(requestFund: state.requestFund.copyWith(billImages: [...images])));
  }

  void reset() {
    emit(const RequestFundFormUpdate());
  }
}
