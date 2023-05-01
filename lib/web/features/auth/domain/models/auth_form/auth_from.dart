import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_from.freezed.dart';

part 'auth_from.g.dart';

@freezed
class AuthForm with _$AuthForm {
  const factory AuthForm({
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool obscureText,
    @Default(AutovalidateMode.disabled) AutovalidateMode autoValidateMode,
  }) = _AuthForm;

  factory AuthForm.fromJson(Map<String, dynamic> json) => _$AuthFormFromJson(json);
}
