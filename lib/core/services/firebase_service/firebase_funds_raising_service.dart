import 'package:aitebar/core/constants/firebase_key.dart';
import 'package:aitebar/core/enums/status_type.dart';
import 'package:aitebar/core/extensions/string_extension.dart';
import 'package:aitebar/core/logging/logger.dart';
import 'package:aitebar/core/services/domain/funds_raising_facade.dart';
import 'package:aitebar/mobile/features/create_funds_raising/domain/models/funds_raising/funds_raising.dart';
import 'package:aitebar/web/features/funds_details/domain/models/funds_raising_donations/funds_raising_donation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IFundsRaisingFacade)
class FirebaseFundsRaisingService implements IFundsRaisingFacade {
  final _firestore = FirebaseFirestore.instance;
  final _log = getLogger('FirebaseFundsRaisingService');

  @override
  Future fetchAllFundsRaising({String? uid, StatusType? status}) async {
    try {
      CollectionReference reference = _firestore.collection(FirebaseKey.fundsRaising);
      Query query = reference;
      if (status != null) {
        query = reference.where(FirebaseKey.status, isEqualTo: status.value);
      }
      if (uid != null) {
        query = query.where(FirebaseKey.uid, isEqualTo: uid);
      }
      QuerySnapshot querySnapshot = await query.orderBy(FirebaseKey.createdAt, descending: true).get();
      List<FundsRaising> fundsRaisingList = [];
      for (var element in querySnapshot.docs) {
        fundsRaisingList.add(FundsRaising.fromJson(element.data() as Map<String, dynamic>));
      }
      return fundsRaisingList;
    } catch (e, stackTrace) {
      _log.e('fetchAllFundsRaising: $e $stackTrace');
      rethrow;
    }
  }

  @override
  Future createFundsRaising({required FundsRaising fundsRaising}) async {
    try {
      CollectionReference reference = _firestore.collection(FirebaseKey.fundsRaising);
      String id = reference.doc().id;
      fundsRaising = fundsRaising.copyWith(
        id: id,
        referenceId: id.referenceId,
        createdAt: DateTime.now(),
      );
      await reference.doc(fundsRaising.id).set(fundsRaising.toJson());
    } on FirebaseException catch (e, stackTrace) {
      _log.e('createFundsRaising: $e $stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      _log.e('createFundsRaising: $e $stackTrace');
      rethrow;
    }
  }

  @override
  Future<void> updateFundsRaising({required FundsRaising fundsRaising}) async {
    try {
      CollectionReference reference = _firestore.collection(FirebaseKey.fundsRaising);
      fundsRaising = fundsRaising.copyWith(updatedAt: DateTime.now());
      await reference.doc(fundsRaising.id).update(fundsRaising.toJson());
    } on FirebaseException catch (e, stackTrace) {
      _log.e('createFundsRaising: $e $stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      _log.e('createFundsRaising: $e $stackTrace');
      rethrow;
    }
  }

  @override
  Future addFundsRaisingDonation({required FundsRaisingDonation fundsRaisingDonation}) async {
    try {
      // fundsRaisingDonation = fundsRaisingDonation.copyWith(id: id, createdAt: DateTime.now());
      String id = fundsRaisingDonation.id;

      WriteBatch batch = _firestore.batch();
      DocumentReference ref1 = _firestore.collection(FirebaseKey.fundsRaisingDonation).doc(id);
      batch.set(ref1, fundsRaisingDonation.toJson());

      DocumentReference ref2 = _firestore.collection(FirebaseKey.fundsRaising).doc(fundsRaisingDonation.fundsRaisingId);
      batch.update(
        ref2,
        {
          FirebaseKey.raisedAmount: FieldValue.increment(fundsRaisingDonation.amount),
          FirebaseKey.transactions: FieldValue.arrayUnion([id]),
          FirebaseKey.donors: FieldValue.arrayUnion([id]),
        },
      );

      await batch.commit();
    } on FirebaseException catch (e, stackTrace) {
      _log.e('createFundsRaising: $e $stackTrace');
      rethrow;
    } catch (e, stackTrace) {
      _log.e('createFundsRaising: $e $stackTrace');
      rethrow;
    }
  }

  @override
  Future<List<FundsRaisingDonation>> fetchAllDonations({required String fundsRaisingId}) async {
    try {
      CollectionReference reference = _firestore.collection(FirebaseKey.fundsRaisingDonation);

      QuerySnapshot querySnapshot =
          await reference.where(FirebaseKey.fundsRaisingId, isEqualTo: fundsRaisingId).orderBy(FirebaseKey.createdAt, descending: true).get();
      List<FundsRaisingDonation> items = [];
      for (var element in querySnapshot.docs) {
        items.add(FundsRaisingDonation.fromJson(element.data() as Map<String, dynamic>));
      }
      return items;
    } catch (e, stackTrace) {
      _log.e('fetchAllFundsRaising: $e $stackTrace');
      rethrow;
    }
  }
}
