extension StringExtension on String {
  String onlyNumber() {
    RegExp exp = RegExp(r'[^0-9]');
    return replaceAll(exp, '');
  }
}
