part of 'manage_funds_raising_cubit.dart';

@freezed
class ManageFundsRaisingState with _$ManageFundsRaisingState {
  const factory ManageFundsRaisingState.initial() = _Initial;

  const factory ManageFundsRaisingState.loading() = _Loading;

  const factory ManageFundsRaisingState.success(FundsRaising fundsRaising) = _Success;

  const factory ManageFundsRaisingState.failure(String message) = _Failure;
}
