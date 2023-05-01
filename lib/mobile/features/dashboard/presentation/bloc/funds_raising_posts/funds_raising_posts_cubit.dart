import 'package:aitebar/core/enums/status_type.dart';
import 'package:aitebar/core/logging/logger.dart';
import 'package:aitebar/core/services/domain/funds_raising_facade.dart';
import 'package:aitebar/mobile/features/create_funds_raising/domain/models/funds_raising/funds_raising.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'funds_raising_posts_state.dart';

@lazySingleton
class FundsRaisingPostsCubit extends Cubit<FundsRaisingPostsState> {
  final IFundsRaisingFacade fundsRaisingFacade;
  final _log = getLogger('FundsRaisingPostsCubit');

  FundsRaisingPostsCubit(this.fundsRaisingFacade) : super(const FundsRaisingPostsInitial());

  Future<void> fetchFundsRaising({String? uid, StatusType? status}) async {
    try {
      emit(const FundsRaisingPostsLoading());
      List<FundsRaising> items = await fundsRaisingFacade.fetchAllFundsRaising(uid: uid, status: status);
      emit(FundsRaisingPostsLoaded(items: items));
    } on FirebaseException catch (e, stackTrace) {
      _log.e('FundsRaisingPostsCubit.fetchAllFundsRaisingPosts: $e $stackTrace');
      emit(FundsRaisingPostsError(message: e.toString(), items: state.items));
    } catch (e, stackTrace) {
      _log.e('FundsRaisingPostsCubit.fetchAllFundsRaisingPosts: $e $stackTrace');
      emit(FundsRaisingPostsError(message: e.toString(), items: state.items));
    }
  }
}
