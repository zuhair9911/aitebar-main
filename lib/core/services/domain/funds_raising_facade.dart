import 'package:aitebar/core/enums/status_type.dart';
import 'package:aitebar/mobile/features/create_funds_raising/domain/models/funds_raising/funds_raising.dart';
import 'package:aitebar/web/features/funds_details/domain/models/funds_raising_donations/funds_raising_donation.dart';

abstract class IFundsRaisingFacade<T> {
  Future<T> fetchAllFundsRaising({String? uid, StatusType? status});

  Future<T> createFundsRaising({required FundsRaising fundsRaising});

  Future<T> updateFundsRaising({required FundsRaising fundsRaising});

  Future<T> addFundsRaisingDonation({required FundsRaisingDonation fundsRaisingDonation});

  Future<List<FundsRaisingDonation>> fetchAllDonations({required String fundsRaisingId});
}
