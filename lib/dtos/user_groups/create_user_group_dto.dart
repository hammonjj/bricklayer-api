import 'package:json_annotation/json_annotation.dart';

part 'create_user_group_dto.g.dart';

@JsonSerializable()
class CreateUserGroupDto {
  final int userId;
  final int groupId;

  CreateUserGroupDto({required this.userId, required this.groupId});

  factory CreateUserGroupDto.fromJson(Map<String, dynamic> json) => _$CreateUserGroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserGroupDtoToJson(this);
}
