import 'package:json_annotation/json_annotation.dart';

part 'response_user_dto.g.dart';

@JsonSerializable()
class ResponseUserDto {
  final int id;
  final String name;
  final String email;

  ResponseUserDto({required this.id, required this.name, required this.email});

  factory ResponseUserDto.fromJson(Map<String, dynamic> json) => _$ResponseUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseUserDtoToJson(this);
}
