import 'package:aitebar/core/constants/app_strings.dart';
import 'package:aitebar/core/constants/firebase_key.dart';
import 'package:aitebar/core/extensions/firebase_exception_extension.dart';
import 'package:aitebar/web/features/auth/domain/auth_facade.dart';
import 'package:aitebar/web/features/auth/domain/models/admin/admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAdminAuthFacade)
class FirebaseAuthService extends IAdminAuthFacade {
  final FirebaseAuth _firebase = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future login(String email, String password) async {
    try {
      UserCredential credential = await _firebase.signInWithEmailAndPassword(email: email, password: password);
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore.collection(FirebaseKey.admin).doc(credential.user!.uid).get();
      if (snapshot.exists) {
        if (snapshot.data() == null) return AppStrings.youReNotAnAdmin;
        return Admin.fromJson(snapshot.data()!);
      } else {
        return AppStrings.youReNotAnAdmin;
      }
    } on FirebaseException catch (e, stackTrace) {
      debugPrint('FirebaseAuthService.login: on $e $stackTrace');
      return e.toFirebaseMessage();
    } catch (e, stackTrace) {
      debugPrint('FirebaseAuthService.login: $e $stackTrace');
      return e.toString();
    }
  }

  @override
  Future<void> signOut() {
    return _firebase.signOut();
  }
}
