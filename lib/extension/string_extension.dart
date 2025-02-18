extension StringExtension on String {
  String splitDomain() {
    return split('@').last.toLowerCase().trim();
  }

  String toSentenceCase() {
    if (trim().isEmpty) {
      return '';
    }
    return split(' ')
        .map((element) =>
            "${element[0].toUpperCase()}${element.substring(1).toLowerCase()}")
        .join(" ");
  }
}
