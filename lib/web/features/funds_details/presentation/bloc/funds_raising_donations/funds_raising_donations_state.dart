part of 'funds_raising_donations_cubit.dart';

@immutable
abstract class FundsRaisingDonationsState {
  final List<FundsRaisingDonation> items;

  const FundsRaisingDonationsState({this.items = const []});

  FundsRaisingDonationsState copyWith({List<FundsRaisingDonation>? items});
}

class FundsRaisingDonationsInitial extends FundsRaisingDonationsState {
  const FundsRaisingDonationsInitial({List<FundsRaisingDonation> items = const []}) : super(items: items);

  @override
  FundsRaisingDonationsInitial copyWith({List<FundsRaisingDonation>? items}) {
    return FundsRaisingDonationsInitial(items: items ?? this.items);
  }
}

class FundsRaisingDonationsLoading extends FundsRaisingDonationsState {
  const FundsRaisingDonationsLoading({List<FundsRaisingDonation> items = const []}) : super(items: items);

  @override
  FundsRaisingDonationsLoading copyWith({List<FundsRaisingDonation>? items}) {
    return FundsRaisingDonationsLoading(items: items ?? this.items);
  }
}

class FundsRaisingDonationsSuccess extends FundsRaisingDonationsState {
  final FundsRaisingDonation? addDonation;
  const FundsRaisingDonationsSuccess({List<FundsRaisingDonation> items = const [], this.addDonation}) : super(items: items);

  @override
  FundsRaisingDonationsSuccess copyWith({List<FundsRaisingDonation>? items}) {
    return FundsRaisingDonationsSuccess(items: items ?? this.items);
  }
}

class FundsRaisingDonationsFailure extends FundsRaisingDonationsState {
  final String message;

  const FundsRaisingDonationsFailure({required this.message, List<FundsRaisingDonation> items = const []}) : super(items: items);

  @override
  FundsRaisingDonationsFailure copyWith({List<FundsRaisingDonation>? items}) {
    return FundsRaisingDonationsFailure(message: '', items: items ?? this.items);
  }
}
