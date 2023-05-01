part of 'manage_funds_request_cubit.dart';

@freezed
class ManageFundsRequestState with _$ManageFundsRequestState {
  const factory ManageFundsRequestState.initial() = _Initial;
  const factory ManageFundsRequestState.loading() = _Loading;
  const factory ManageFundsRequestState.success({required FundsRequest fundsRequest}) = _Success;
  const factory ManageFundsRequestState.failure({required String message}) = _Failure;
}
