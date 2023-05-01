import 'package:aitebar/core/mixins/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_form_state.dart';

@lazySingleton
class AuthFormCubit extends Cubit<AuthFormState> with Validators {
  AuthFormCubit() : super(const AuthFormUpdate());

  void onChangedName(String name) => emit(state.copyWith(name: name));

  void onChangedEmail(String email) => emit(state.copyWith(email: email));

  void onChangedPassword(String password) => emit(state.copyWith(password: password));

  void onChangedConfirmPassword(String confirmPassword) => emit(state.copyWith(confirmPassword: confirmPassword));

  void passwordObscureToggle() => emit(state.copyWith(passwordObscure: !state.passwordObscure));

  void passwordConfirmObscureToggle() => emit(state.copyWith(confirmPasswordObscure: !state.confirmPasswordObscure));

  bool get isValidSignInForm {
    return isValidEmail(state.email) && isValidPassword(state.password);
  }

  bool get isValidSignUpForm {
    return (state.name?.length ?? 0) > 2 && isValidEmail(state.email) && isValidPassword(state.password) && state.confirmPassword == state.password;
  }

  void reset() => emit(const AuthFormUpdate());

  void setAutovalidateMode(AutovalidateMode autovalidateMode) {
    emit(state.copyWith(autovalidateMode: autovalidateMode));
  }
}
