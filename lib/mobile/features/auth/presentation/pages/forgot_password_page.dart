import 'package:aitebar/core/components/app_button.dart';
import 'package:aitebar/core/components/sb.dart';
import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/core/mixins/input_formatters.dart';
import 'package:aitebar/core/mixins/validators.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/mobile/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:aitebar/mobile/features/auth/presentation/blocs/auth_form_cubit/auth_form_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ForgotPasswordPage extends StatelessWidget with Validators, InputFormatter {
  ForgotPasswordPage({super.key});

  final _authFormCubit = sl<AuthFormCubit>();
  final _authBloc = sl<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: context.vertical,
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                color: context.background.withOpacity(0.6),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
              ),
              child: Column(
                children: [
                  SB.h(16.0),
                  Text(
                    AppStrings.loginToYourAccount,
                    style: context.titleLarge,
                  ),
                  SB.h(16.0),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: context.background,
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
                    ),
                    child: Column(
                      children: [
                        const Text(AppStrings.forgotPassword),
                        SB.h(16.0),
                        TextFormField(
                          inputFormatters: [noSpaceFormatter],
                          validator: validateEmail,
                          onChanged: _authFormCubit.onChangedEmail,
                        ),
                        SB.h(16.0),
                        SB.h(8.0),
                        BlocSelector<AuthFormCubit, AuthFormState, bool>(
                          bloc: _authFormCubit,
                          selector: (_) => _authFormCubit.isValidEmail(_.email),
                          builder: (context, isValidForm) {
                            return BlocConsumer<AuthBloc, AuthState>(
                              bloc: _authBloc,
                              listener: (context, state) {
                                state.whenOrNull(
                                  resetPasswordMailSent: (state) {
                                    context.showToast(AppStrings.resetPasswordMailSend);
                                    context.router.back();
                                  },
                                  failure: (message) {
                                    context.showToast(message);
                                  },
                                );
                              },
                              builder: (context, state) {
                                return AppButton.gradient(
                                  isProcessing: state == const AuthState.loading(),
                                  onPressed: !isValidForm ? null : () => _sendResetMail(_authFormCubit.state.email),
                                  child: const Text(AppStrings.resetMail),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _sendResetMail(String? email) {
    if (email == null) return;
    _authBloc.add(AuthEvent.resetPassword(email: email));
  }
}
