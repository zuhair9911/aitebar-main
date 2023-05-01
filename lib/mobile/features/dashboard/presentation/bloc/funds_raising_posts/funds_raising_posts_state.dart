part of 'funds_raising_posts_cubit.dart';

@immutable
abstract class FundsRaisingPostsState {
  final List<FundsRaising> items;

  const FundsRaisingPostsState({
    required this.items,
  });

  FundsRaisingPostsState copyWith({List<FundsRaising>? items});
}

class FundsRaisingPostsInitial extends FundsRaisingPostsState {
  const FundsRaisingPostsInitial({
    List<FundsRaising> items = const [],
  }) : super(items: items);

  @override
  FundsRaisingPostsState copyWith({List<FundsRaising>? items}) {
    return FundsRaisingPostsInitial(items: items ?? this.items);
  }
}

class FundsRaisingPostsLoading extends FundsRaisingPostsState {
  const FundsRaisingPostsLoading({
    List<FundsRaising> items = const [],
  }) : super(items: items);

  @override
  FundsRaisingPostsState copyWith({List<FundsRaising>? items}) {
    return FundsRaisingPostsLoading(items: items ?? this.items);
  }
}

class FundsRaisingPostsLoaded extends FundsRaisingPostsState {
  const FundsRaisingPostsLoaded({
    List<FundsRaising> items = const [],
  }) : super(items: items);

  @override
  FundsRaisingPostsState copyWith({List<FundsRaising>? items}) {
    return FundsRaisingPostsLoaded(items: items ?? this.items);
  }
}

class FundsRaisingPostsError extends FundsRaisingPostsState {
  final String message;

  const FundsRaisingPostsError({
    required this.message,
    List<FundsRaising> items = const [],
  }) : super(items: items);

  @override
  FundsRaisingPostsState copyWith({List<FundsRaising>? items}) {
    return FundsRaisingPostsError(message: message, items: items ?? this.items);
  }
}
