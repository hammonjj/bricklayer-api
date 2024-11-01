import 'package:dartomite/utils/json_converters/uuid_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'set_piece_dto.g.dart';

@JsonSerializable()
class SetPieceDto {
  @RequiredGuidConverter()
  final UuidValue id;

  @RequiredGuidConverter()
  final UuidValue userPieceId;

  @RequiredGuidConverter()
  final UuidValue userSetId;

  final int quantity;

  SetPieceDto({
    required this.id,
    required this.userPieceId,
    required this.userSetId,
    required this.quantity,
  });

  factory SetPieceDto.fromModelData(Map<String, dynamic> data) {
    return SetPieceDto(
      id: UuidValue.fromString(data['id'] as String),
      userPieceId: UuidValue.fromString(data['user_piece_id'] as String),
      userSetId: UuidValue.fromString(data['user_set_id'] as String),
      quantity: data['count'] as int,
    );
  }

  factory SetPieceDto.fromJson(Map<String, dynamic> json) => _$SetPieceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SetPieceDtoToJson(this);
}
