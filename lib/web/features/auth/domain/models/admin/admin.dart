import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin.freezed.dart';

part 'admin.g.dart';

@freezed
class Admin with _$Admin {
  const factory Admin({
    required final String uid,
    required final String name,
    required final String email,
    required final DateTime createdAt,
  }) = _Admin;

  factory Admin.fromJson(Map<String, dynamic> json) => _$AdminFromJson(json);
}
