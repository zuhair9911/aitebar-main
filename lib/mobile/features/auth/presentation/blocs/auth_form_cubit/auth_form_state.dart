part of 'auth_form_cubit.dart';

@immutable
abstract class AuthFormState {
  final String? name;
  final String? email;
  final String? password;
  final String? confirmPassword;
  final bool passwordObscure;
  final bool confirmPasswordObscure;
  final AutovalidateMode autovalidateMode;

  const AuthFormState({
    this.name,
    this.email,
    this.password,
    this.confirmPassword,
    this.passwordObscure = true,
    this.confirmPasswordObscure = true,
    this.autovalidateMode = AutovalidateMode.disabled,
  });

  AuthFormState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    bool? passwordObscure,
    bool? confirmPasswordObscure,
    AutovalidateMode? autovalidateMode,
  });
}

class AuthFormUpdate extends AuthFormState {
  const AuthFormUpdate({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    bool? passwordObscure,
    bool? confirmPasswordObscure,
    AutovalidateMode? autovalidateMode,
  }) : super(
          name: name,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          passwordObscure: passwordObscure ?? true,
          confirmPasswordObscure: confirmPasswordObscure ?? true,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
        );

  @override
  AuthFormUpdate copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    bool? passwordObscure,
    bool? confirmPasswordObscure,
    AutovalidateMode? autovalidateMode,
  }) {
    return AuthFormUpdate(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      passwordObscure: passwordObscure ?? this.passwordObscure,
      confirmPasswordObscure: confirmPasswordObscure ?? this.confirmPasswordObscure,
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
    );
  }
}
