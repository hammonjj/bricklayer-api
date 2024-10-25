import 'package:dartomite/dtos/groups/create_group_dto.dart';
import 'package:dartomite/dtos/groups/response_group_dto.dart';
import 'package:dartomite/dtos/groups/update_group_dto.dart';
import 'package:dartomite/repositories/group_repository.dart';

class GroupService {
  final GroupRepository groupRepository;

  GroupService(this.groupRepository);

  Future<List<ResponseGroupDto>> getAllGroups() {
    return groupRepository.getAllGroups();
  }

  Future<ResponseGroupDto?> getGroupById(int id) {
    return groupRepository.getGroupById(id);
  }

  Future<ResponseGroupDto> createGroup(CreateGroupDto groupData) {
    return groupRepository.createGroup(groupData);
  }

  Future<void> updateGroup(int id, UpdateGroupDto groupData) {
    return groupRepository.updateGroup(id, groupData);
  }

  Future<void> deleteGroup(int id) {
    return groupRepository.deleteGroup(id);
  }
}
