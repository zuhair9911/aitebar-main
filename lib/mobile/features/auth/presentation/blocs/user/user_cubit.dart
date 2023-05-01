import 'package:aitebar/core/services/domain/auth_facade.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/mobile/features/auth/domain/models/user/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final IAuthFacade _authFacade = sl<IAuthFacade>();

  UserCubit() : super(const UserInitial());

  void init(AppUser user) {
    emit(UserAuthState(user: user));
  }

  Future<void> refresh() async {
    if (uid != null) {
      var data = await _authFacade.getUser(uid: uid!);
      if (data is AppUser) emit(UserAuthState(user: data));
    }
  }

  void update(AppUser user) {
    emit(UserAuthState(user: user));
  }

  void reset() {
    emit(const UserInitial());
  }

  Future<void> logout() async {
    await _authFacade.logout();
    emit(const UserInitial());
  }

  bool get isAuthorized {
    return FirebaseAuth.instance.currentUser != null && uid != null;
  }

  String? get uid => FirebaseAuth.instance.currentUser?.uid;
}
