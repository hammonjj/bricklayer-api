import 'package:dartomite/database/database.dart';
import 'package:dartomite/dtos/groups/create_group_dto.dart';
import 'package:dartomite/dtos/groups/response_group_dto.dart';
import 'package:dartomite/dtos/groups/update_group_dto.dart';
import 'package:drift/drift.dart';

class GroupRepository {
  final AppDatabase db;

  GroupRepository(this.db);

  Future<List<ResponseGroupDto>> getAllGroups() async {
    final query = db.select(db.groups);
    final groups = await query.get();

    return groups
        .map((group) => ResponseGroupDto(
              id: group.id,
              name: group.name,
            ))
        .toList();
  }

  Future<ResponseGroupDto?> getGroupById(int id) async {
    final query = db.select(db.groups)..where((tbl) => tbl.id.equals(id));
    final group = await query.getSingleOrNull();

    if (group == null) return null;

    return ResponseGroupDto(
      id: group.id,
      name: group.name,
    );
  }

  Future<ResponseGroupDto> createGroup(CreateGroupDto groupData) async {
    final groupId = await db.into(db.groups).insert(
          GroupsCompanion(
            name: Value(groupData.name),
          ),
        );

    return ResponseGroupDto(
      id: groupId,
      name: groupData.name,
    );
  }

  Future<void> updateGroup(int id, UpdateGroupDto groupData) async {
    final query = db.update(db.groups)..where((tbl) => tbl.id.equals(id));
    await query.write(
      GroupsCompanion(
        name: Value(groupData.name),
      ),
    );
  }

  Future<void> deleteGroup(int id) async {
    final query = db.delete(db.groups)..where((tbl) => tbl.id.equals(id));
    await query.go();
  }
}
