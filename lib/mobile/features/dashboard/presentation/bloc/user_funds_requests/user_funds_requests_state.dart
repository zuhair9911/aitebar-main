part of 'user_funds_requests_cubit.dart';

@freezed
class UserFundsRequestsState with _$UserFundsRequestsState {
  const factory UserFundsRequestsState.initial({@Default([]) List<FundsRequest> items}) = _Initial;

  const factory UserFundsRequestsState.loading({@Default([]) List<FundsRequest> items}) = _Loading;

  const factory UserFundsRequestsState.success({@Default([]) List<FundsRequest> items}) = _Success;

  const factory UserFundsRequestsState.failure({@Default([]) List<FundsRequest> items, required String message}) = _Failure;
}
