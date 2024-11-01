import 'package:dartomite/dtos/bricklayer/set_piece_dto.dart';
import 'package:dartomite/dtos/bricklayer/user_set_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_user_set_response.g.dart';

@JsonSerializable()
class CreateUserSetResponse {
  final UserSetDto setInfo;
  final List<SetPieceDto> setPieces;

  CreateUserSetResponse({required this.setInfo, required this.setPieces});

  factory CreateUserSetResponse.fromJson(Map<String, dynamic> json) => _$CreateUserSetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserSetResponseToJson(this);
}
