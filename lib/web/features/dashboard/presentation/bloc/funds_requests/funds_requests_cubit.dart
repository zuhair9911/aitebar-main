import 'package:aitebar/core/services/domain/funds_request_facade.dart';
import 'package:aitebar/core/sl/service_locator.dart';
import 'package:aitebar/mobile/features/create_funds_request/domain/models/request_fund/funds_request.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'funds_requests_state.dart';

@lazySingleton
class FundsRequestsCubit extends Cubit<FundsRequestsState> {
  final _service = sl<IFundsRequestFacade>();

  FundsRequestsCubit() : super(const FundsRequestsInitial());

  Future<void> getAllFundsRequests() async {
    emit(const FundsRequestsLoading());
    try {
      List<FundsRequest> items = await _service.getAllFundsRequests();
      emit(FundsRequestsSuccess(items: items));
    } on FirebaseException catch (e) {
      emit(FundsRequestsFailure(items: state.items, message: e.message!));
    } catch (e) {
      emit(FundsRequestsFailure(items: state.items, message: e.toString()));
    }
  }

  Future<void> updateFundsRequest({required FundsRequest fundsRequest}) async {
    List<FundsRequest> items = [...state.items];
    int index = items.indexWhere((element) => element.id == fundsRequest.id);
    if (index != -1) {
    items[index] = fundsRequest;
    }
    emit(FundsRequestsSuccess(items: items));
  }

}
