extension StringExtension on String {
  /// funds raising donation id
  String get referenceId => substring(0, length ~/ 3).toUpperCase();
}
