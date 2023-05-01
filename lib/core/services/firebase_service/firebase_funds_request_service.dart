import 'package:aitebar/core/constants/firebase_key.dart';
import 'package:aitebar/core/enums/status_type.dart';
import 'package:aitebar/core/services/domain/funds_request_facade.dart';
import 'package:aitebar/mobile/features/create_funds_request/domain/models/request_fund/funds_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IFundsRequestFacade)
class FirebaseFundsRequestService extends IFundsRequestFacade {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createFundsRequest({required FundsRequest fundsRequest}) async {
    try {
      CollectionReference reference = _firestore.collection(FirebaseKey.fundsRequest);
      String id = reference.doc().id;
      fundsRequest = fundsRequest.copyWith(
        id: id,
        createdAt: DateTime.now(),
      );
      await reference.doc(fundsRequest.id).set(fundsRequest.toJson());
    } catch (e, stackTrace) {
      debugPrint('FundsRaisingService.createFundsRaising: $e $stackTrace');
      rethrow;
    }
  }

  Future<List<FundsRequest>> fetchFundsRequest({bool? isApproved, String? uid}) {
    try {
      CollectionReference reference = _firestore.collection(FirebaseKey.fundsRequest);
      Query query = reference;
      if (isApproved != null) {
        query = reference.where(FirebaseKey.isApproved, isEqualTo: true);
      }
      if (uid != null) {
        query = query.where(FirebaseKey.uid, isEqualTo: uid);
      }
      return query.orderBy(FirebaseKey.createdAt, descending: true).get().then((value) {
        List<FundsRequest> items = [];
        for (var element in value.docs) {
          items.add(FundsRequest.fromJson(element.data() as Map<String, dynamic>));
        }
        return items;
      });
    } catch (e, stackTrace) {
      debugPrint('FundsRequestService.fetchFundsRequest: $e $stackTrace');
      rethrow;
    }
  }

  @override
  Future<void> updateFundsRequest({required FundsRequest fundsRequest}) async {
    try {
      CollectionReference reference = _firestore.collection(FirebaseKey.fundsRequest);
      fundsRequest = fundsRequest.copyWith(updatedAt: DateTime.now());
      await reference.doc(fundsRequest.id).update(fundsRequest.toJson());
    } catch (e, stackTrace) {
      debugPrint('FundsRaisingService.createFundsRaising: $e $stackTrace');
      rethrow;
    }
  }

  @override
  Future<List<FundsRequest>> getAllFundsRequests({String? uid, StatusType? status}) async {
    try {
      CollectionReference reference = _firestore.collection(FirebaseKey.fundsRequest);
      Query query = reference;
      if (status != null) {
        query = reference.where(FirebaseKey.status, isEqualTo: status.value);
      }
      if (uid != null) {
        query = query.where(FirebaseKey.uid, isEqualTo: uid);
      }
      QuerySnapshot querySnapshot = await query.orderBy(FirebaseKey.createdAt, descending: true).get();
      List<FundsRequest> items = [];
      for (var element in querySnapshot.docs) {
        items.add(FundsRequest.fromJson(element.data() as Map<String, dynamic>));
      }
      return items;
    } catch (_) {
      rethrow;
    }
  }
}
