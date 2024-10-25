import 'package:dartomite/database/database.dart';
import 'package:dartomite/dtos/user_groups/create_user_group_dto.dart';
import 'package:dartomite/dtos/user_groups/response_user_group_dto.dart';
import 'package:dartomite/dtos/user_groups/update_user_group_dto.dart';
import 'package:drift/drift.dart';

class UserGroupRepository {
  final AppDatabase db;

  UserGroupRepository(this.db);

  Future<List<ResponseUserGroupDto>> getAllUserGroups() async {
    final query = db.select(db.userGroups);
    final userGroups = await query.get();

    return userGroups
        .map((userGroup) => ResponseUserGroupDto(
              id: userGroup.id,
              userId: userGroup.userId,
              groupId: userGroup.groupId,
            ))
        .toList();
  }

  Future<ResponseUserGroupDto?> getUserGroupById(int id) async {
    final query = db.select(db.userGroups)..where((tbl) => tbl.id.equals(id));
    final userGroup = await query.getSingleOrNull();

    if (userGroup == null) return null;

    return ResponseUserGroupDto(
      id: userGroup.id,
      userId: userGroup.userId,
      groupId: userGroup.groupId,
    );
  }

  Future<ResponseUserGroupDto> createUserGroup(CreateUserGroupDto userGroupData) async {
    final userGroupId = await db.into(db.userGroups).insert(
          UserGroupsCompanion(
            userId: Value(userGroupData.userId),
            groupId: Value(userGroupData.groupId),
          ),
        );

    return ResponseUserGroupDto(
      id: userGroupId,
      userId: userGroupData.userId,
      groupId: userGroupData.groupId,
    );
  }

  Future<void> updateUserGroup(int id, UpdateUserGroupDto userGroupData) async {
    final query = db.update(db.userGroups)..where((tbl) => tbl.id.equals(id));
    await query.write(
      UserGroupsCompanion(
        userId: Value(userGroupData.userId),
        groupId: Value(userGroupData.groupId),
      ),
    );
  }

  Future<void> deleteUserGroup(int id) async {
    final query = db.delete(db.userGroups)..where((tbl) => tbl.id.equals(id));
    await query.go();
  }
}
