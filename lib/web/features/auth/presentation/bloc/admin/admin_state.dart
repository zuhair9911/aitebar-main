part of 'admin_cubit.dart';
//
// @immutable
// abstract class AdminState {
//   final Admin? admin;
//
//   const AdminState({ this.admin});
// }
//
// class AdminInitial extends AdminState {
//   const AdminInitial({ super.admin});
// }
//
// class AdminLoggedIn extends AdminState {
//   const AdminLoggedIn({ super.admin});
// }

@freezed
class AdminState with _$AdminState {
  factory AdminState.initial({final Admin? admin}) = _Initial;

  factory AdminState.loggedIn({required final Admin admin}) = _LoggedIn;
}
