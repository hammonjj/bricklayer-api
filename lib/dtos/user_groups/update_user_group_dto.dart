import 'package:json_annotation/json_annotation.dart';

part 'update_user_group_dto.g.dart';

@JsonSerializable()
class UpdateUserGroupDto {
  final int userId;
  final int groupId;

  UpdateUserGroupDto({required this.userId, required this.groupId});

  factory UpdateUserGroupDto.fromJson(Map<String, dynamic> json) => _$UpdateUserGroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserGroupDtoToJson(this);
}
