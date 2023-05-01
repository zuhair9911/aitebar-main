import 'package:aitebar/core/logging/logger.dart';
import 'package:aitebar/core/services/domain/auth_facade.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/mobile/features/auth/domain/models/user/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'users_cubit.freezed.dart';

part 'users_state.dart';

@lazySingleton
class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(const UsersState.initial());
  final IAuthFacade _authService = sl<IAuthFacade>();
  final _log = getLogger('UsersCubit');

  Future<void> fetchUsers() async {
    emit(const UsersState.loading());
    try {
      List<AppUser> users = await _authService.getAllUsers();
      emit(UsersState.success(users: users));
    } on FirebaseException catch (e, stackTrace) {
      _log.e('fetchUsers: $e $stackTrace');
      emit(UsersState.failure(message: e.message!));
    } catch (e, stackTrace) {
      _log.e('fetchUsers: $e $stackTrace');
      emit(UsersState.failure(message: e.toString()));
    }
  }
}
