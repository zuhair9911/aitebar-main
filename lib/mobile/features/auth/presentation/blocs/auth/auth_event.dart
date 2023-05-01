part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.signUp({
    required final String name,
    required final String email,
    required final String password,
  }) = _SignUp;

  const factory AuthEvent.login({
    required String email,
    required String password,
  }) = _Login;

  const factory AuthEvent.fetchUser({
    required String uid,
  }) = _FetchUser;

  const factory AuthEvent.resetPassword({
    required String email,
  }) = _ResetPassword;
}
