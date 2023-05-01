import 'package:aitebar/core/convertor/status_type_convertor.dart';
import 'package:aitebar/core/enums/status_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'funds_raising.freezed.dart';

part 'funds_raising.g.dart';

@freezed
class FundsRaising with _$FundsRaising {
  const factory FundsRaising({
    @Default('') final String uid,
    @Default('') final String id,
    @Default('') final String title,
    @Default('') final String description,
    @Default(0) final num requireAmount,
    @Default(0) final num raisedAmount,
    @Default('') final String address,
    @Default('') final String contactNumber,
    @Default('') final String category,
    @Default('') final String email,
    final String? referenceId,
    @Default([]) final List<String> images,
    @Default([]) final List<String> donors,
    @Default([]) final List<String> transactions,
    // StatusType: pending, approved, rejected
    @StatusTypeConvertor() @Default(StatusType.pending) final StatusType status,
    final String? statusMessage,
    final String? adminId,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final DateTime? lastDonation,
    // Bank Details
    @Default('') final String accountTitle,
    @Default('') final String accountNumber,
    @Default('') final String bankName,
  }) = _FundsRaising;

  factory FundsRaising.fromJson(Map<String, dynamic> json) => _$FundsRaisingFromJson(json);
}
