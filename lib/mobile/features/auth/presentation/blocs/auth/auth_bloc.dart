import 'dart:async';

import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/extensions/firebase_exception_extension.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/core/services/domain/auth_facade.dart';
import 'package:aitebar/mobile/features/auth/domain/models/user/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_bloc.freezed.dart';

part 'auth_event.dart';

part 'auth_state.dart';

@Injectable()
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthFacade _authFacade = sl<IAuthFacade>();

  AuthBloc() : super(const AuthState.initial()) {
    on<_Login>(_loginAttempt);
    on<_SignUp>(_signUpAttempt);
    on<_FetchUser>(_fetchUserProfile);
    on<_ResetPassword>(_resetPassword);
  }

  Future<FutureOr<void>> _loginAttempt(_Login event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    dynamic res = await _authFacade.login(email: event.email, password: event.password);
    if (res is UserCredential) {
      await _getUser(res.user!.uid, emit);
    } else {
      emit(AuthState.failure(message: res.toString()));
    }
  }

  Future<FutureOr<void>> _signUpAttempt(_SignUp event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());

    dynamic res = await _authFacade.signUp(email: event.email, password: event.password);
    if (res is UserCredential) {
      await _createUser(res.user!.uid, event, emit);
    } else {
      emit(AuthState.failure(message: res.toString()));
    }
  }

  Future<void> _createUser(String uid, _SignUp event, Emitter<AuthState> emit) async {
    AppUser appUser = AppUser(
      uid: uid,
      email: event.email,
      name: event.name,
      createdAt: DateTime.now(),
    );

    dynamic res = await _authFacade.createUser(id: uid, map: appUser.toJson());
    if (res is String) {
      emit(AuthState.failure(message: res));
    } else {
      emit(AuthState.success(user: appUser));
    }
  }

  FutureOr<void> _fetchUserProfile(_FetchUser event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    await _getUser(event.uid, emit);
  }

  Future<void> _getUser(String uid, Emitter<AuthState> emit) async {
    dynamic res = await _authFacade.getUser(uid: uid);
    if (res is AppUser) {
      emit(AuthState.success(user: res));
    } else {
      emit(AuthState.failure(message: res));
    }
  }

  FutureOr<void> _resetPassword(_ResetPassword event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      await _authFacade.forgotPassword(email: event.email);
      emit(const AuthState.resetPasswordMailSent(message: 'Email sent successfully'));
    } on FirebaseException catch (e) {
      debugPrint('AuthBloc.forgotPassword: $e');
      emit(AuthState.failure(message: e.toFirebaseMessage()));
    } catch (e) {
      debugPrint('AuthBloc.forgotPassword: $e');
      emit(AuthState.failure(message: AppStrings.somethingWentWrong));
    }
  }
}
