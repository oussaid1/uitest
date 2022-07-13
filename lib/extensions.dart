/// extension on [List<String>] to turn all items to lower case
extension LowerCaseList on List<String> {
  List<String> toLowerCase() {
    for (int i = 0; i < length; i++) {
      this[i] = this[i].toLowerCase();
    }
    return this;
  }
}

/// extension on DateTime to get a string in the format dd/mm/yyyy
extension DateTimeExt on DateTime {
  String ddmmyyyy() {
    return '$day/$month/$year';
  }
}
