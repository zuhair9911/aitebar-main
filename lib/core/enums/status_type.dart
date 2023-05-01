import 'package:aitebar/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

enum StatusType {
  approved(AppStrings.approved, Colors.green),
  pending(AppStrings.pending, Colors.red),
  rejected(AppStrings.rejected, Colors.red),
  delete(AppStrings.delete, Colors.red);

  final String value;
  final Color color;

  const StatusType(this.value, this.color);
}
