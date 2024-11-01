import 'package:dartomite/utils/json_converters/uuid_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'user_piece_dto.g.dart';

@JsonSerializable()
class UserPieceDto {
  @RequiredGuidConverter()
  final UuidValue id;

  final String legoPartId;
  final String name;
  final int quantity;
  final int inUseCount;
  final String? imageUrl;
  final String? partUrl;

  UserPieceDto({
    required this.id,
    required this.legoPartId,
    required this.name,
    required this.quantity,
    required this.inUseCount,
    this.imageUrl,
    this.partUrl,
  });

  factory UserPieceDto.fromJson(Map<String, dynamic> json) => _$UserPieceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserPieceDtoToJson(this);
}
