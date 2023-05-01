import 'package:aitebar/core/constants/firebase_key.dart';
import 'package:aitebar/core/logging/logger.dart';
import 'package:aitebar/core/services/domain/auth_facade.dart';
import 'package:aitebar/mobile/features/auth/domain/models/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:injectable/injectable.dart';

@Injectable(as: IAuthFacade)
class AuthService extends IAuthFacade {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _log = getLogger('AuthService');

  @override
  Future<dynamic> signUp({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e, stackTrace) {
      _log.e('AuthService.login: $e, $stackTrace');
      return e.message;
    } catch (e, stackTrace) {
      _log.e('AuthService.login: $e $stackTrace');
      return e;
    }
  }

  @override
  Future<dynamic> login({required String email, required String password}) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e, stackTrace) {
      _log.e('AuthService.login: $e, $stackTrace');
      return e.message;
    } catch (e, stackTrace) {
      _log.e('AuthService.login: $e $stackTrace');
      return e.toString();
    }
  }

  @override
  Future<dynamic> createUser({required String id, required Map<String, dynamic> map}) async {
    try {
      await _firestore.collection(FirebaseKey.users).doc(id).set(map);
      return;
    } on FirebaseException catch (e, stackTrace) {
      _log.e('AuthService.createUser: $e, $stackTrace');
      return e.message;
    } catch (e, stackTrace) {
      _log.e('AuthService.createUser: $e $stackTrace');
      return e.toString();
    }
  }

  @override
  Future<dynamic> updateUser({required AppUser user}) async {
    try {
      await _firestore.collection(FirebaseKey.users).doc(user.uid).update(user.toJson());
      return;
    } on FirebaseException catch (e, stackTrace) {
      _log.e('AuthService.createUser: $e, $stackTrace');
      return e.message;
    } catch (e, stackTrace) {
      _log.e('AuthService.createUser: $e $stackTrace');
      return e.toString();
    }
  }

  @override
  Future logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<dynamic> getUser({required String uid}) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await _firestore.collection(FirebaseKey.users).doc(uid).get();
      if (doc.exists && (doc.data()?.isNotEmpty ?? false)) {
        Map<String, dynamic> data = doc.data()!;
        return AppUser.fromJson(data);
      } else {
        return 'User not found';
      }
    } on FirebaseException catch (e, stackTrace) {
      _log.e('AuthService.createUser: $e, $stackTrace');
      return e.message;
    } catch (e, stackTrace) {
      _log.e('AuthService.createUser: $e $stackTrace');
      return e.toString();
    }
  }

  @override
  Future forgotPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e, stackTrace) {
      _log.e('AuthService.forgotPassword: $e, $stackTrace');
      rethrow;
    }
  }

  @override
  Future<List<AppUser>> getAllUsers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> doc = await _firestore.collection(FirebaseKey.users).get();
      List<AppUser> items = [];
      items = doc.docs.map((e) => AppUser.fromJson(e.data())).toList();
      return items;
    } catch (e, stackTrace) {
      _log.e('AuthService.forgotPassword: $e, $stackTrace');
      rethrow;
    }
  }
}
