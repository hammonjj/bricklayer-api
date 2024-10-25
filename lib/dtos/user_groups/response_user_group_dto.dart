import 'package:json_annotation/json_annotation.dart';

part 'response_user_group_dto.g.dart';

@JsonSerializable()
class ResponseUserGroupDto {
  final int id;
  final int userId;
  final int groupId;

  ResponseUserGroupDto({required this.id, required this.userId, required this.groupId});

  factory ResponseUserGroupDto.fromJson(Map<String, dynamic> json) => _$ResponseUserGroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseUserGroupDtoToJson(this);
}
