import 'package:aitebar/core/logging/logger.dart';
import 'package:aitebar/core/services/domain/funds_raising_facade.dart';
import 'package:aitebar/mobile/features/create_funds_raising/domain/models/funds_raising/funds_raising.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'manage_funds_raising_cubit.freezed.dart';

part 'manage_funds_raising_state.dart';

@Injectable()
class ManageFundsRaisingCubit extends Cubit<ManageFundsRaisingState> {
  final IFundsRaisingFacade _fundsRaisingService;
  final _log = getLogger('FundsRaisingCubit');

  ManageFundsRaisingCubit(this._fundsRaisingService) : super(const ManageFundsRaisingState.initial());

  Future<void> updateFundsRaising({required FundsRaising fundsRaising}) async {
    emit(const ManageFundsRaisingState.loading());
    try {
      await _fundsRaisingService.updateFundsRaising(fundsRaising: fundsRaising);
      emit(ManageFundsRaisingState.success(fundsRaising));
    } on FirebaseException catch (e) {
      _log.e(e);
      emit(ManageFundsRaisingState.failure(e.message!));
    } catch (e) {
      _log.e(e);
      emit(ManageFundsRaisingState.failure(e.toString()));
    }
  }
}
