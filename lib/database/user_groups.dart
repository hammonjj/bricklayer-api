import 'package:dartomite/database/groups.dart';
import 'package:dartomite/database/users.dart';
import 'package:drift/drift.dart';

class UserGroups extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id, onDelete: KeyAction.cascade)();
  IntColumn get groupId => integer().references(Groups, #id)();
}
