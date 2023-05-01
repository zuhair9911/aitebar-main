import 'package:cloud_firestore/cloud_firestore.dart';

extension FirebaseExceptionExtension on FirebaseException {
  String toFirebaseMessage() {
    String message = '';
    switch (code) {
      case 'invalid-email':
        message = 'The email address is not valid.';
        break;
      case 'user-disabled':
        message = 'The user corresponding to the given email has been disabled.';
        break;
      case 'user-not-found':
        message = 'There is no user corresponding to the given email.';
        break;
      case 'wrong-password':
        message = 'The password is invalid for the given email, or the account corresponding to the email does not have a password set.';
        break;

      case 'email-already-in-use':
        message = 'There already exists an account with the given email address.';
        break;
      case 'operation-not-allowed':
        message = 'Email/password accounts are not enabled. Enable email/password accounts in the Firebase Console, under the Auth tab.';
        break;
      case 'weak-password':
        message = 'The password is not strong enough.';
        break;
      case 'unknown':
        message = 'There is no user record corresponding to this identifier. The user may have been deleted.';
        break;
      default:
        message = 'An undefined Error happened.';
    }
    return message;
  }
}
