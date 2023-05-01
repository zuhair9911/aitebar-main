part of 'user_cubit.dart';

@immutable
abstract class UserState {
  final AppUser? user;

  const UserState({required this.user});
}

class UserInitial extends UserState {
  const UserInitial({super.user});
}

class UserLogoutState extends UserState {
  const UserLogoutState({super.user});
}

class UserAuthState extends UserState {
  const UserAuthState({required super.user});
}

class UserFailureState extends UserState {
  final String message;

  const UserFailureState({required super.user, required this.message});
}
