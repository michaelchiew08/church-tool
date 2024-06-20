extension ForWeb on String {
  String forWeb({required bool web}) =>
      web ? replaceFirst('assets/', '') : this;
}
