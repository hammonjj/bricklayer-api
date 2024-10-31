extension EqualsIgnoreCase on String {
  bool equalsIgnoreCase(String string) {
    return toLowerCase() == string.toLowerCase();
  }
}
