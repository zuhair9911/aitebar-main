part of 'users_cubit.dart';

@freezed
class UsersState with _$UsersState {
  const factory UsersState.initial({@Default([]) List<AppUser> users}) = _Initial;
  const factory UsersState.loading({@Default([]) List<AppUser> users}) = _Loading;
  const factory UsersState.success({@Default([]) List<AppUser> users}) = _Success;
  const factory UsersState.failure({required String message, @Default([]) List<AppUser> users}) = _Failure;
}
