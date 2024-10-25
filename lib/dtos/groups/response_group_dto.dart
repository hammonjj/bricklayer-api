import 'package:json_annotation/json_annotation.dart';

part 'response_group_dto.g.dart';

@JsonSerializable()
class ResponseGroupDto {
  final int id;
  final String name;

  ResponseGroupDto({required this.id, required this.name});

  factory ResponseGroupDto.fromJson(Map<String, dynamic> json) => _$ResponseGroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseGroupDtoToJson(this);
}
