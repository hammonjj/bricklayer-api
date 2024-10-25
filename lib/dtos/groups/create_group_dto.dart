import 'package:json_annotation/json_annotation.dart';

part 'create_group_dto.g.dart';

@JsonSerializable()
class CreateGroupDto {
  final String name;

  CreateGroupDto({required this.name});

  factory CreateGroupDto.fromJson(Map<String, dynamic> json) => _$CreateGroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGroupDtoToJson(this);
}
