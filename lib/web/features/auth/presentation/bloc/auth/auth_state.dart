part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;

  const factory AuthState.loading() = _Loading;

  const factory AuthState.success(Admin admin) = _Success;

  const factory AuthState.failure(String message) = _Failure;
}
