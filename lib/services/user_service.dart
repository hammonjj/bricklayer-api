import 'package:dartomite/dtos/user_groups/create_user_group_dto.dart';
import 'package:dartomite/dtos/user_groups/update_user_group_dto.dart';
import 'package:dartomite/dtos/users/create_user_dto.dart';
import 'package:dartomite/dtos/users/response_user_dto.dart';
import 'package:dartomite/dtos/users/update_user_dto.dart';
import 'package:dartomite/exceptions/user_creation_exception.dart';
import 'package:dartomite/exceptions/user_update_exception.dart';
import 'package:dartomite/repositories/user_group_repository.dart';
import 'package:dartomite/repositories/user_repository.dart';

class UserService {
  final UserRepository userRepository;
  final UserGroupRepository userGroupRepository;

  UserService(this.userRepository, this.userGroupRepository);

  Future<List<ResponseUserDto>> getAllUsers() {
    return userRepository.getAllUsers();
  }

  Future<ResponseUserDto?> getUserById(int id) {
    return userRepository.getUserById(id);
  }

  Future<ResponseUserDto> createUser(CreateUserDto userData) async {
    try {
      final user = await userRepository.createUser(userData);

      await userGroupRepository.createUserGroup(CreateUserGroupDto(userId: user.id, groupId: userData.groupId));

      return user;
    } catch (e) {
      throw UserCreationException('Failed to create user: ${userData.name}');
    }
  }

  Future<ResponseUserDto?> updateUser(int id, UpdateUserDto userData) async {
    try {
      final updatedUser = await userRepository.updateUser(id, userData);

      if (updatedUser != null && userData.groupId != null) {
        await userGroupRepository.updateUserGroup(id, UpdateUserGroupDto(userId: id, groupId: userData.groupId!));
      }

      return updatedUser;
    } catch (e) {
      throw UserUpdateException('Failed to update user with ID: $id - Exception Message: $e');
    }
  }

  Future<void> deleteUser(int id) {
    return userRepository.deleteUser(id);
  }
}
