import 'package:aitebar/core/constants/app_strings.dart';

enum AppCategory {
  education(AppStrings.education),
  health(AppStrings.health),
  environment(AppStrings.environment),
  animal(AppStrings.animal),
  disaster(AppStrings.disaster),
  other(AppStrings.other);

  final String value;
  const AppCategory(this.value);

}