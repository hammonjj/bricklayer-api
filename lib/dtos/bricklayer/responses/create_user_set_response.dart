import 'package:dartomite/dtos/bricklayer/user_set_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_user_set_response.g.dart';

@JsonSerializable()
class CreateUserSetResponse {
  // Will eventually add the part info
  final UserSetDto setInfo;

  CreateUserSetResponse({required this.setInfo});

  factory CreateUserSetResponse.fromJson(Map<String, dynamic> json) => _$CreateUserSetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserSetResponseToJson(this);
}
