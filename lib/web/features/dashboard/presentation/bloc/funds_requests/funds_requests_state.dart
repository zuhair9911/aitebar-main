part of 'funds_requests_cubit.dart';

@immutable
abstract class FundsRequestsState {
  final List<FundsRequest> items;

  const FundsRequestsState({this.items = const []});
}

class FundsRequestsInitial extends FundsRequestsState {
  const FundsRequestsInitial({List<FundsRequest> items = const []}) : super(items: items);
}

class FundsRequestsLoading extends FundsRequestsState {
  const FundsRequestsLoading({List<FundsRequest> items = const []}) : super(items: items);
}

class FundsRequestsSuccess extends FundsRequestsState {
  const FundsRequestsSuccess({List<FundsRequest> items = const []}) : super(items: items);
}

class FundsRequestsFailure extends FundsRequestsState {
  final String message;

  const FundsRequestsFailure({required this.message, List<FundsRequest> items = const []}) : super(items: items);
}
