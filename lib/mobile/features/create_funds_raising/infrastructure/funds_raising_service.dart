// import 'package:aitebar/core/constants/firebase_key.dart';
// import 'package:aitebar/mobile/features/create_funds_raising/domain/funds_raising_facade.dart';
// import 'package:aitebar/mobile/features/create_funds_raising/domain/models/funds_raising/funds_raising.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:injectable/injectable.dart';
//
// @LazySingleton(as: IFundsRaisingManageFacade)
// class FundsRaisingService extends IFundsRaisingManageFacade {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   Future createFundsRaising({required FundsRaising fundsRaising}) async {
//     try {
//       CollectionReference reference = _firestore.collection(FirebaseKey.fundsRaising);
//       String id = reference.doc().id;
//       fundsRaising = fundsRaising.copyWith(
//         id: id,
//         createdAt: DateTime.now(),
//       );
//       await reference.doc(fundsRaising.id).set(fundsRaising.toJson());
//     } on FirebaseException catch (e, stackTrace) {
//       debugPrint('FundsRaisingService.createFundsRaising: $e $stackTrace');
//       rethrow;
//     } catch (e, stackTrace) {
//       debugPrint('FundsRaisingService.createFundsRaising: $e $stackTrace');
//       rethrow;
//     }
//   }
// }
