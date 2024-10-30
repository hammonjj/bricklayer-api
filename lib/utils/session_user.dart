import 'package:uuid/uuid.dart';

class SessionUser {
  final UuidValue id;
  final String username;

  SessionUser({required this.id, required this.username});
}
