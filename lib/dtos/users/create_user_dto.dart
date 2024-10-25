import 'package:json_annotation/json_annotation.dart';

part 'create_user_dto.g.dart';

@JsonSerializable()
class CreateUserDto {
  final String name;
  final String email;
  final String password;
  final int groupId;

  CreateUserDto({
    required this.name,
    required this.email,
    required this.password,
    required this.groupId,
  });

  factory CreateUserDto.fromJson(Map<String, dynamic> json) => _$CreateUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserDtoToJson(this);
}
