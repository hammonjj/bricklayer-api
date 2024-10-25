class UserCreationException implements Exception {
  final String message;

  UserCreationException([this.message = 'User creation failed.']);

  @override
  String toString() => message;
}
