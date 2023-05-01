import 'package:aitebar/core/extensions/app_theme_extension.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  MaterialColor get primarySwatch;

  MaterialColor createMaterialColor(Color color);

  Color get primary;

  Color get onPrimary;

  Color get secondary;

  Color get onSecondary;

  Color get errorColor;

  Color get scaffoldBackgroundColor;

  Color get cardColor;

  AppThemeExtension get extension;

  InputDecorationTheme get inputDecorationTheme;

  TextTheme get textTheme;
}
