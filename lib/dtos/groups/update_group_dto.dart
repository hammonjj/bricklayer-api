import 'package:json_annotation/json_annotation.dart';

part 'update_group_dto.g.dart';

@JsonSerializable()
class UpdateGroupDto {
  final String name;

  UpdateGroupDto({required this.name});

  factory UpdateGroupDto.fromJson(Map<String, dynamic> json) => _$UpdateGroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateGroupDtoToJson(this);
}
