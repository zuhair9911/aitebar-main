import 'package:freezed_annotation/freezed_annotation.dart';

part 'funds_raising_donation.freezed.dart';

part 'funds_raising_donation.g.dart';

@freezed
class FundsRaisingDonation with _$FundsRaisingDonation {
  const factory FundsRaisingDonation({
    @Default('') String id,
    @Default('') String fundsRaisingId,
    @Default(0) num amount,
    DateTime? createdAt,
    @Default('') String adminId,
  }) = _FundsRaisingDonation;

  factory FundsRaisingDonation.fromJson(Map<String, dynamic> json) => _$FundsRaisingDonationFromJson(json);
}
