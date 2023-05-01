import 'package:aitebar/core/enums/status_type.dart';
import 'package:aitebar/mobile/features/create_funds_request/domain/models/request_fund/funds_request.dart';

abstract class IFundsRequestFacade {
  Future<List<FundsRequest>> getAllFundsRequests({String? uid, StatusType? status});

  Future<void> createFundsRequest({required FundsRequest fundsRequest});

  Future<void> updateFundsRequest({required FundsRequest fundsRequest});

  // Future<List<FundsRequest>> fetchFundsRequest({bool? isApproved, String? uid});
}
