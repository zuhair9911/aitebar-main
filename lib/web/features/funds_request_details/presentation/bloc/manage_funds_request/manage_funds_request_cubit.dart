import 'package:aitebar/core/logging/logger.dart';
import 'package:aitebar/core/services/domain/funds_request_facade.dart';
import 'package:aitebar/mobile/features/create_funds_request/domain/models/request_fund/funds_request.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'manage_funds_request_cubit.freezed.dart';

part 'manage_funds_request_state.dart';

@Injectable()
class ManageFundsRequestCubit extends Cubit<ManageFundsRequestState> {
  final IFundsRequestFacade _service;
  final _log = getLogger('FundsRaisingCubit');

  ManageFundsRequestCubit(this._service) : super(const ManageFundsRequestState.initial());

  Future<void> updateFundsRaising({required FundsRequest item}) async {
    emit(const ManageFundsRequestState.loading());
    try {
      await _service.updateFundsRequest(fundsRequest: item);
      emit(ManageFundsRequestState.success(fundsRequest: item));
    } on FirebaseException catch (e) {
      _log.e(e);
      emit(ManageFundsRequestState.failure(message: e.message!));
    } catch (e) {
      _log.e(e);
      emit(ManageFundsRequestState.failure(message: e.toString()));
    }
  }
}
