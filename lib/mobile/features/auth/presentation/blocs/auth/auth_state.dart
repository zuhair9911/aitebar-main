part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;

  const factory AuthState.loading() = _Loading;

  const factory AuthState.success({required AppUser user}) = _Success;

  const factory AuthState.failure({required String message}) = _Failure;

  const factory AuthState.resetPasswordMailSent({required String message}) = _ResetPasswordMailSent;
}
