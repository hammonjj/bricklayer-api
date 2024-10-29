import 'package:dartomite/utils/json_converters/uuid_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'user_set_dto.g.dart';

@JsonSerializable()
class UserSetDto {
  @RequiredGuidConverter()
  final UuidValue id;

  final String? setId;
  final String? brand;
  final String name;
  final bool currentlyBuilt;
  final String? setUrl;
  final String? imageUrl;
  final String? instructionsUrl;

  UserSetDto(
      {required this.id,
      required this.name,
      required this.currentlyBuilt,
      this.setId,
      this.brand,
      this.setUrl,
      this.imageUrl,
      this.instructionsUrl});

  factory UserSetDto.fromJson(Map<String, dynamic> json) => _$UserSetDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserSetDtoToJson(this);
}
