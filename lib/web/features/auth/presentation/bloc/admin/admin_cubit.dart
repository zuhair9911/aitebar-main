import 'package:aitebar/core/constants/firebase_key.dart';
import 'package:aitebar/web/features/auth/domain/models/admin/admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'admin_cubit.freezed.dart';

part 'admin_state.dart';

@lazySingleton
class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminState.initial());

  final FirebaseAuth _firebase = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void initForRefresh() {
    if (_firebase.currentUser != null) {
      _firestore.collection(FirebaseKey.admin).doc(_firebase.currentUser!.uid).get().then((value) {
        if (value.exists) {
          emit(AdminState.loggedIn(admin: Admin.fromJson(value.data()!)));
        } else {
          emit(AdminState.initial());
        }
      });
    }
  }

  void init(Admin admin) {
    emit(AdminState.loggedIn(admin: admin));
  }

  Future<void> logout() async {
    await _firebase.signOut();
    emit(AdminState.initial());
  }
}
