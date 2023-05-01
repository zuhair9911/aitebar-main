part of 'funds_raising_cubit.dart';

@freezed
class FundsRaisingState with _$FundsRaisingState {
  factory FundsRaisingState.initial({@Default([]) List<FundsRaising> items}) = _Initial;

  factory FundsRaisingState.loading({@Default([]) List<FundsRaising> items}) = _Loading;

  factory FundsRaisingState.success({@Default([]) List<FundsRaising> items}) = _Success;

  factory FundsRaisingState.failure({@Default([]) List<FundsRaising> items, required String message}) = _Failure;
}
