import 'package:dartomite/dtos/user_groups/create_user_group_dto.dart';
import 'package:dartomite/dtos/user_groups/response_user_group_dto.dart';
import 'package:dartomite/dtos/user_groups/update_user_group_dto.dart';
import 'package:dartomite/repositories/user_group_repository.dart';

class UserGroupService {
  final UserGroupRepository userGroupRepository;

  UserGroupService(this.userGroupRepository);

  Future<List<ResponseUserGroupDto>> getAllUserGroups() {
    return userGroupRepository.getAllUserGroups();
  }

  Future<ResponseUserGroupDto?> getUserGroupById(int id) {
    return userGroupRepository.getUserGroupById(id);
  }

  Future<ResponseUserGroupDto> createUserGroup(CreateUserGroupDto userGroupData) {
    return userGroupRepository.createUserGroup(userGroupData);
  }

  Future<void> updateUserGroup(int id, UpdateUserGroupDto userGroupData) {
    return userGroupRepository.updateUserGroup(id, userGroupData);
  }

  Future<void> deleteUserGroup(int id) {
    return userGroupRepository.deleteUserGroup(id);
  }
}
