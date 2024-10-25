class UserUpdateException implements Exception {
  final String message;

  UserUpdateException([this.message = 'User update failed.']);

  @override
  String toString() => message;
}
