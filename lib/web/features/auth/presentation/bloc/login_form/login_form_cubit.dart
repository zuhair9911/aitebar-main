import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'login_form_state.dart';

@Injectable()
class LoginFormCubit extends Cubit<LoginFormState> {
  LoginFormCubit() : super(const LoginStateUpdate());

  void onChangedEmail(String value) {
    emit(state.copyWith(email: value));
  }

  void onChangedPassword(String value) {
    emit(state.copyWith(password: value));
  }

  void onAutoValidateMode() {
    emit(state.copyWith(autoValidateMode: AutovalidateMode.always));
  }

  void passwordObscureToggle() {
    emit(state.copyWith(obscureText: !state.obscureText));
  }

  void setAutovalidateMode(AutovalidateMode always) {
    emit(state.copyWith(autoValidateMode: always));
  }
}
