import 'dart:math';

import 'package:aitebar/core/components/app_button.dart';
import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/core/mixins/validators.dart';
import 'package:aitebar/core/routes/web_routes/web_router.gr.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/gen/assets.gen.dart';
import 'package:aitebar/web/features/auth/domain/models/admin/admin.dart';
import 'package:aitebar/web/features/auth/presentation/bloc/admin/admin_cubit.dart';
import 'package:aitebar/web/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:aitebar/web/features/auth/presentation/bloc/login_form/login_form_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

@RoutePage()
class AuthPage extends StatelessWidget with Validators {
  AuthPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final AuthCubit _authCubit = sl<AuthCubit>();
  final LoginFormCubit _formCubit = sl<LoginFormCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: min(context.width, 500.0),
          child: Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocSelector<LoginFormCubit, LoginFormState, AutovalidateMode>(
                bloc: _formCubit,
                selector: (state) => state.autoValidateMode,
                builder: (context, autovalidateMode) {
                  return Form(
                    key: _formKey,
                    autovalidateMode: autovalidateMode,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          Assets.app.appLogo.path,
                          height: 120.0,
                          color: context.primary,
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          onChanged: _formCubit.onChangedEmail,
                          decoration: const InputDecoration(hintText: AppStrings.email),
                          validator: validateEmail,
                        ),
                        const SizedBox(height: 16.0),
                        BlocSelector<LoginFormCubit, LoginFormState, bool>(
                          bloc: _formCubit,
                          selector: (state) => state.obscureText,
                          builder: (context, obscureText) {
                            return TextFormField(
                              obscureText: obscureText,
                              onChanged: _formCubit.onChangedPassword,
                              obscuringCharacter: AppStrings.obscuringCharacter,
                              validator: validatePassword,
                              decoration: InputDecoration(
                                hintText: AppStrings.password,
                                suffixIcon: IconButton(
                                  icon: Icon(obscureText ? LineIcons.eye : LineIcons.eyeSlash),
                                  onPressed: _formCubit.passwordObscureToggle,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24.0),
                        BlocConsumer<AuthCubit, AuthState>(
                          bloc: _authCubit,
                          listener: (context, state) {
                            state.whenOrNull(
                              success: (Admin admin) {
                                sl<AdminCubit>().init(admin);
                                context.router.replaceAll([const AdminDashboardRoute()]);
                              },
                              failure: (String message) => context.showToast(message),
                            );
                          },
                          builder: (context, state) {
                            return AppButton(
                              isProcessing: state == const AuthState.loading(),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _authCubit.login(_formCubit.state.email, _formCubit.state.password);
                                } else {
                                  _formCubit.setAutovalidateMode(AutovalidateMode.always);
                                }
                              },
                              background: context.primary,
                              foregroundColor: context.onPrimary,
                              child: const Text(AppStrings.login),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
