import 'package:aitebar/core/logging/logger.dart';
import 'package:aitebar/core/services/domain/funds_raising_facade.dart';
import 'package:aitebar/web/features/funds_details/domain/models/funds_raising_donations/funds_raising_donation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'funds_raising_donations_state.dart';

@lazySingleton
class FundsRaisingDonationsCubit extends Cubit<FundsRaisingDonationsState> {
  final _log = getLogger('FundsRaisingDonationsCubit');
  final IFundsRaisingFacade _service;

  FundsRaisingDonationsCubit(this._service) : super(const FundsRaisingDonationsInitial());

  Future<void> fetchFundsRaising({required String fundsRaisingId}) async {
    emit(const FundsRaisingDonationsLoading(items: []));
    try {
      List<FundsRaisingDonation> items = await _service.fetchAllDonations(fundsRaisingId: fundsRaisingId);
      emit(FundsRaisingDonationsSuccess(items: items));
    } on FirebaseException catch (e) {
      emit(FundsRaisingDonationsFailure(items: state.items, message: e.message!));
    } catch (e) {
      emit(FundsRaisingDonationsFailure(items: state.items, message: e.toString()));
    }
  }

  Future<void> addDonation(FundsRaisingDonation donation) async {
    try {
      emit(FundsRaisingDonationsLoading(items: state.items));
      await _service.addFundsRaisingDonation(fundsRaisingDonation: donation);
      emit(FundsRaisingDonationsSuccess(items: [...state.items, donation], addDonation: donation));
    } on FirebaseException catch (e) {
      emit(FundsRaisingDonationsFailure(message: e.message ?? '', items: state.items));
      _log.e(e.toString());
    } catch (e) {
      _log.e(e.toString());
      emit(FundsRaisingDonationsFailure(message: e.toString(), items: state.items));
    }
  }
}
