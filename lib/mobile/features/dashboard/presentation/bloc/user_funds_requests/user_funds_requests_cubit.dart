import 'package:aitebar/core/enums/status_type.dart';
import 'package:aitebar/core/logging/logger.dart';
import 'package:aitebar/core/services/domain/funds_request_facade.dart';
import 'package:aitebar/mobile/features/create_funds_request/domain/models/request_fund/funds_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_funds_requests_cubit.freezed.dart';

part 'user_funds_requests_state.dart';

@lazySingleton
class UserFundsRequestsCubit extends Cubit<UserFundsRequestsState> {
  final IFundsRequestFacade _fundsRequestFacade;

  final _log = getLogger('UserFundsRequestsCubit');

  UserFundsRequestsCubit(this._fundsRequestFacade) : super(const UserFundsRequestsState.initial());

  Future<void> fetchFundsRequest({StatusType? status, String? uid}) async {
    emit(const UserFundsRequestsState.loading());
    try {
      List<FundsRequest> items = await _fundsRequestFacade.getAllFundsRequests(uid: uid, status: status);
      emit(UserFundsRequestsState.success(items: items));
    } catch (e, stackTrace) {
      _log.e('fetchFundsRequest: $e $stackTrace');
      emit(UserFundsRequestsState.failure(items: state.items, message: e.toString()));
    }
  }

  void createFundsRequest(FundsRequest fundsRequest) {
    emit(UserFundsRequestsState.success(items: [...state.items, fundsRequest]));
  }

  void updateFundsRequest(FundsRequest fundsRequest) {
    List<FundsRequest> items = state.items.map((e) => e.id == fundsRequest.id ? fundsRequest : e).toList();
    emit(UserFundsRequestsState.success(items: items));
  }
}
