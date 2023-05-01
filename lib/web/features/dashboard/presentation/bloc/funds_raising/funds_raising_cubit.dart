import 'package:aitebar/core/logging/logger.dart';
import 'package:aitebar/core/services/domain/funds_raising_facade.dart';
import 'package:aitebar/mobile/features/create_funds_raising/domain/models/funds_raising/funds_raising.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'funds_raising_cubit.freezed.dart';

part 'funds_raising_state.dart';

@lazySingleton
class FundsRaisingCubit extends Cubit<FundsRaisingState> {
  final IFundsRaisingFacade _fundsRaisingService;
  final _log = getLogger('FundsRaisingCubit');

  FundsRaisingCubit(this._fundsRaisingService) : super(FundsRaisingState.initial());

  Future<void> fetchFundsRaising({bool? isApproved, String? uid}) async {
    emit(FundsRaisingState.loading(items: []));
    try {
      List<FundsRaising> items = await _fundsRaisingService.fetchAllFundsRaising();
      emit(FundsRaisingState.success(items: items));
    } on FirebaseException catch (e) {
      emit(FundsRaisingState.failure(items: state.items, message: e.message!));
    } catch (e) {
      emit(FundsRaisingState.failure(items: state.items, message: e.toString()));
    }
  }

  Future<void> updateFundsRaising({required FundsRaising fundsRaising}) async {
    List<FundsRaising> items = [...state.items];
    int index = items.indexWhere((element) => element.id == fundsRaising.id);
    if (index != -1) {
      items[index] = fundsRaising;
    }
    emit(FundsRaisingState.success(items: items));
  }
}
