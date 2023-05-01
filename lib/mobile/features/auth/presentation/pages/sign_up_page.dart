import 'package:aitebar/core/components/app_button.dart';
import 'package:aitebar/core/components/sb.dart';
import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/extensions/build_context_extension.dart';
import 'package:aitebar/core/mixins/input_formatters.dart';
import 'package:aitebar/core/mixins/validators.dart';
import 'package:aitebar/core/routes/app_routes/app_router.gr.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/mobile/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:aitebar/mobile/features/auth/presentation/blocs/auth_form_cubit/auth_form_cubit.dart';
import 'package:aitebar/mobile/features/auth/presentation/blocs/user/user_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

@RoutePage()
class SignUpPage extends StatelessWidget with Validators, InputFormatter {
  SignUpPage({Key? key}) : super(key: key);
  final _authFormCubit = sl<AuthFormCubit>();
  final _authBloc = sl<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: context.width,
          height: context.height - context.paddingTop,
          child: Stack(
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
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    // color: context.background.withOpacity(0.6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      // SB.h(16.0),
                      // Text(
                      //   AppStrings.signUpToCreateAnAccount,
                      //   style: context.titleLarge,
                      // ),
                      SB.h(16.0),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: context.background,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24.0),
                            topRight: Radius.circular(24.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            const Text(AppStrings.signUpWithEmail),
                            SB.h(16.0),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(AppStrings.name,
                                  style: context.bodyLarge
                                      ?.copyWith(color: context.primary)),
                            ),
                            TextFormField(
                              onChanged: _authFormCubit.onChangedName,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: validateName,
                            ),
                            SB.h(16.0),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(AppStrings.email,
                                  style: context.bodyLarge
                                      ?.copyWith(color: context.primary)),
                            ),
                            TextFormField(
                              inputFormatters: [noSpaceFormatter],
                              onChanged: _authFormCubit.onChangedEmail,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: validateEmail,
                            ),
                            SB.h(16.0),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(AppStrings.password,
                                  style: context.bodyLarge
                                      ?.copyWith(color: context.primary)),
                            ),
                            BlocSelector<AuthFormCubit, AuthFormState, bool>(
                              bloc: _authFormCubit,
                              selector: (state) => state.passwordObscure,
                              builder: (context, isObscure) {
                                return TextFormField(
                                  inputFormatters: [noSpaceFormatter],
                                  obscureText: isObscure,
                                  obscuringCharacter:
                                      AppStrings.obscuringCharacter,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(isObscure
                                          ? LineIcons.eye
                                          : LineIcons.eyeSlash),
                                      onPressed:
                                          _authFormCubit.passwordObscureToggle,
                                    ),
                                  ),
                                  validator: validatePassword,
                                  onChanged: _authFormCubit.onChangedPassword,
                                );
                              },
                            ),
                            SB.h(16.0),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(AppStrings.confirmPassword,
                                  style: context.bodyLarge
                                      ?.copyWith(color: context.primary)),
                            ),
                            BlocSelector<AuthFormCubit, AuthFormState, bool>(
                              bloc: _authFormCubit,
                              selector: (state) => state.confirmPasswordObscure,
                              builder: (context, isObscure) {
                                return TextFormField(
                                  inputFormatters: [noSpaceFormatter],
                                  obscureText: isObscure,
                                  obscuringCharacter:
                                      AppStrings.obscuringCharacter,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(isObscure
                                          ? LineIcons.eye
                                          : LineIcons.eyeSlash),
                                      onPressed: _authFormCubit
                                          .passwordConfirmObscureToggle,
                                    ),
                                  ),
                                  validator: (String? value) =>
                                      validateConfirmPassword(
                                          value, _authFormCubit.state.password),
                                  onChanged:
                                      _authFormCubit.onChangedConfirmPassword,
                                );
                              },
                            ),
                            SB.h(16.0),
                            BlocSelector<AuthFormCubit, AuthFormState, bool>(
                              bloc: _authFormCubit,
                              selector: (_) => _authFormCubit.isValidSignUpForm,
                              builder: (context, isValidForm) {
                                debugPrint(
                                    'SignUpSheet.build: isValidForm: $isValidForm');
                                return BlocConsumer<AuthBloc, AuthState>(
                                  bloc: _authBloc,
                                  listener: (context, state) {
                                    state.whenOrNull(
                                      success: (user) {
                                        context.read<UserCubit>().init(user);
                                        context.router
                                            .replaceAll([DashboardRoute()]);
                                      },
                                      failure: (message) {
                                        context.showSnackBar(message);
                                      },
                                    );
                                  },
                                  builder: (context, state) {
                                    return AppButton.gradient(
                                      isProcessing:
                                          state == const AuthState.loading(),
                                      onPressed:
                                          !isValidForm ? null : _attemptSignUp,
                                      child: const Text(AppStrings.signUp),
                                    );
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 20.0),
                            TextButton(
                              onPressed: () => context.router.replaceAll(
                                  [const WelcomeRoute(), SignInRoute()]),
                              child: const Text(
                                  AppStrings.alreadyHaveAnAccountLogin),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // Positioned(
              //   top: 30.0,
              //   left: 0.0,
              //   right: 0.0,
              //   child: Image.asset(
              //     Assets.app.appLogo.path,
              //     height: 180.0,
              //     color: context.onPrimary,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void _attemptSignUp() {
    _authBloc.add(AuthEvent.signUp(
      email: _authFormCubit.state.email!,
      password: _authFormCubit.state.password!,
      name: _authFormCubit.state.name!,
    ));
  }
}
