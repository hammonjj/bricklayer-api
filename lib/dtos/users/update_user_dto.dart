import 'package:json_annotation/json_annotation.dart';

part 'update_user_dto.g.dart';

@JsonSerializable()
class UpdateUserDto {
  final String? name;
  final String? email;
  final String? password;
  final int? groupId;

  UpdateUserDto({
    this.name,
    this.email,
    this.password,
    this.groupId,
  });

  factory UpdateUserDto.fromJson(Map<String, dynamic> json) => _$UpdateUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserDtoToJson(this);
}
