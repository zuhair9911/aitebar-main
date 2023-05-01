import 'package:aitebar/core/convertor/status_type_convertor.dart';
import 'package:aitebar/core/enums/status_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'funds_request.freezed.dart';

part 'funds_request.g.dart';

@freezed
class FundsRequest with _$FundsRequest {
  const factory FundsRequest({
    @Default('') final String uid,
    @Default('') final String id,
    @Default('') final String title,
    @Default('') final String description,
    @Default(0.0) final num requestedAmount,
    @Default('') final String category,
    @Default([]) final List<String> cnicImages,
    @Default([]) final List<String> billImages,
    final bool? isZakatEligible,
    @StatusTypeConvertor() @Default(StatusType.pending) final StatusType status,
    final String? statusMessage,
    final String? adminId,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    // Bank Details
    @Default('') final String accountTitle,
    @Default('') final String accountNumber,
    @Default('') final String bankName,
  }) = _FundsRequest;

  factory FundsRequest.fromJson(Map<String, dynamic> json) => _$FundsRequestFromJson(json);
}
