extension EmailParsing on String {
  String splitDomain() {
    return split('@').last.toLowerCase().trim();
  }
}
