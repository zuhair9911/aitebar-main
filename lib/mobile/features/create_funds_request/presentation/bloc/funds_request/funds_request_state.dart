part of 'funds_request_cubit.dart';

@freezed
class FundsRequestState with _$FundsRequestState {
  const factory FundsRequestState.initial() = _Initial;

  const factory FundsRequestState.loading() = _Loading;

  const factory FundsRequestState.success({required final FundsRequest fundsRequest}) = _Success;

  const factory FundsRequestState.failure({required String message}) = _Failure;
}
