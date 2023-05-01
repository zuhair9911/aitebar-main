part of 'request_fund_form_cubit.dart';

@immutable
abstract class RequestFundFormState {
  final AutovalidateMode autovalidateMode;
  final FundsRequest requestFund;
  final List<UploadingStatusManagerCubit>? cnicUploadingManager;
  final List<UploadingStatusManagerCubit>? billUploadingManager;

  const RequestFundFormState({
    this.autovalidateMode = AutovalidateMode.disabled,
    this.requestFund = const FundsRequest(),
    this.cnicUploadingManager,
    this.billUploadingManager,
  });

  RequestFundFormState copyWith({
    AutovalidateMode? autovalidateMode,
    FundsRequest? requestFund,
    List<UploadingStatusManagerCubit>? cnicUploadingManager,
    List<UploadingStatusManagerCubit>? billUploadingManager,
  });
}

class RequestFundFormUpdate extends RequestFundFormState {
  const RequestFundFormUpdate({
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    FundsRequest? requestFund,
    List<UploadingStatusManagerCubit>? cnicUploadingManager,
    List<UploadingStatusManagerCubit>? billUploadingManager,
  }) : super(
          autovalidateMode: autovalidateMode,
          requestFund: requestFund ?? const FundsRequest(),
          cnicUploadingManager: cnicUploadingManager,
          billUploadingManager: billUploadingManager,
        );

  @override
  RequestFundFormUpdate copyWith({
    AutovalidateMode? autovalidateMode,
    FundsRequest? requestFund,
    List<UploadingStatusManagerCubit>? cnicUploadingManager,
    List<UploadingStatusManagerCubit>? billUploadingManager,
  }) {
    return RequestFundFormUpdate(
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      requestFund: requestFund ?? this.requestFund,
      cnicUploadingManager: cnicUploadingManager ?? this.cnicUploadingManager,
      billUploadingManager: billUploadingManager ?? this.billUploadingManager,
    );
  }
}
