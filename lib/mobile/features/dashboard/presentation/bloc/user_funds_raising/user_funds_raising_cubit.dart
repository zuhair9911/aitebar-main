import 'package:aitebar/mobile/features/create_funds_raising/domain/models/funds_raising/funds_raising.dart';
import 'package:aitebar/core/services/domain/funds_raising_facade.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'user_funds_raising_state.dart';

@lazySingleton
class UserFundsRaisingCubit extends Cubit<UserFundsRaisingState> {
  final IFundsRaisingFacade fundsRaisingFacade;

  UserFundsRaisingCubit(this.fundsRaisingFacade) : super(const UserFundsRaisingInitial());

  Future<void> fetchAllFundsRaisingPosts() async {
    try {
      emit(const UserFundsRaisingLoading());
      String userId = FirebaseAuth.instance.currentUser!.uid;
      List<FundsRaising> items = await fundsRaisingFacade.fetchAllFundsRaising(uid: userId);
      emit(UserFundsRaisingLoaded(items: items));
    } on FirebaseException catch (e, stackTrace) {
      debugPrint('FundsRaisingPostsCubit.fetchAllFundsRaisingPosts: $e $stackTrace');
      emit(UserFundsRaisingError(message: e.toString(), items: state.items));
    } catch (e, stackTrace) {
      debugPrint('FundsRaisingPostsCubit.fetchAllFundsRaisingPosts: $e $stackTrace');
      emit(UserFundsRaisingError(message: e.toString(), items: state.items));
    }
  }
}
