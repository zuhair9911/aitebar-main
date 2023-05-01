part of 'user_funds_raising_cubit.dart';

@immutable
abstract class UserFundsRaisingState { 
  final List<FundsRaising> items;

const UserFundsRaisingState({
  required this.items,
});

UserFundsRaisingState copyWith({List<FundsRaising>? items});
}

class UserFundsRaisingInitial extends UserFundsRaisingState {
  const UserFundsRaisingInitial({
    List<FundsRaising> items = const [],
  }) : super(items: items);

  @override
  UserFundsRaisingInitial copyWith({List<FundsRaising>? items}) {
    return UserFundsRaisingInitial(items: items ?? this.items);
  }
}

class UserFundsRaisingLoading extends UserFundsRaisingState {
  const UserFundsRaisingLoading({
    List<FundsRaising> items = const [],
  }) : super(items: items);

  @override
  UserFundsRaisingLoading copyWith({List<FundsRaising>? items}) {
    return UserFundsRaisingLoading(items: items ?? this.items);
  }
}

class UserFundsRaisingLoaded extends UserFundsRaisingState {
  const UserFundsRaisingLoaded({
    List<FundsRaising> items = const [],
  }) : super(items: items);

  @override
  UserFundsRaisingLoaded copyWith({List<FundsRaising>? items}) {
    return UserFundsRaisingLoaded(items: items ?? this.items);
  }
}

class UserFundsRaisingError extends UserFundsRaisingState {
  final String message;

  const UserFundsRaisingError({
    required this.message,
    List<FundsRaising> items = const [],
  }) : super(items: items);

  @override
  UserFundsRaisingError copyWith({List<FundsRaising>? items}) {
    return UserFundsRaisingError(message: message, items: items ?? this.items);
  }
}
