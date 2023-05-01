import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    @Default('') final String uid,
    final String? name,
    final String? email,
    final DateTime? createdAt,
  }) = _User;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}
