part of 'login_form_cubit.dart';

@immutable
abstract class LoginFormState {
  final String email;
  final String password;
  final bool obscureText;
  final AutovalidateMode autoValidateMode;

  const LoginFormState({
    this.email = '',
    this.password = '',
    this.obscureText = true,
    this.autoValidateMode = AutovalidateMode.disabled,
  });

  LoginFormState copyWith({
    String? email,
    String? password,
    bool? obscureText,
    AutovalidateMode? autoValidateMode,
  });
}

class LoginStateUpdate extends LoginFormState {
  const LoginStateUpdate({
    String? email,
    String? password,
    bool? obscureText,
    AutovalidateMode? autoValidateMode,
  }) : super(
          email: email ?? '',
          password: password ?? '',
          obscureText: obscureText ?? true,
          autoValidateMode: autoValidateMode ?? AutovalidateMode.disabled,
        );

  @override
  LoginStateUpdate copyWith({
    String? email,
    String? password,
    bool? obscureText,
    AutovalidateMode? autoValidateMode,
  }) {
    return LoginStateUpdate(
      email: email ?? this.email,
      password: password ?? this.password,
      obscureText: obscureText ?? this.obscureText,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
    );
  }
}
