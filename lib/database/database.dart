import 'dart:io';

import 'package:dartomite/database/groups.dart';
import 'package:dartomite/database/user_groups.dart';
import 'package:dartomite/database/users.dart';
import 'package:dartomite/utils/hash_password.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    return NativeDatabase(File(p.join(Directory.current.path, 'dartomite.db')));
  });
}

@DriftDatabase(
  tables: [Users, UserGroups, Groups],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');

        if (details.wasCreated) {
          await _seedDatabase();
        }
      },
    );
  }

  Future<void> _seedDatabase() async {
    final adminGroupId = await into(groups).insert(const GroupsCompanion(name: Value('admin')));
    final userGroupId = await into(groups).insert(const GroupsCompanion(name: Value('user')));

    final adminUserId = await into(users).insert(
      UsersCompanion(
        name: const Value('George Beefeater'),
        email: const Value('george.beefeater@dartomite.com'),
        password: Value(hashPassword('beefeater')),
      ),
    );

    final userUserId = await into(users).insert(
      UsersCompanion(
        name: const Value('Laura Leafnibbler'),
        email: const Value('laura.leafnibbler@dartomite.com'),
        password: Value(hashPassword('leafnibbler')),
      ),
    );

    await into(userGroups).insert(UserGroupsCompanion(
      userId: Value(adminUserId),
      groupId: Value(adminGroupId),
    ));

    await into(userGroups).insert(UserGroupsCompanion(
      userId: Value(userUserId),
      groupId: Value(userGroupId),
    ));
  }
}
