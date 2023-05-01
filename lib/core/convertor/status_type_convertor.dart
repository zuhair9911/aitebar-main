import 'package:aitebar/core/enums/status_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class StatusTypeConvertor implements JsonConverter<StatusType?, String?> {
  const StatusTypeConvertor();

  @override
  StatusType fromJson(String? value) {
    return StatusType.values.firstWhere((e) => e.value == value, orElse: () => StatusType.pending);
  }

  @override
  String toJson(StatusType? value) => value?.value ?? StatusType.pending.value;
}
