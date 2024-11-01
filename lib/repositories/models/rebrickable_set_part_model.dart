import 'package:json_annotation/json_annotation.dart';

part 'rebrickable_set_part_model.g.dart';

@JsonSerializable()
class RebrickableSetPartModel {
  final int id;
  final int quantity;

  @JsonKey(name: 'is_spare')
  final bool isSpare;

  @JsonKey(name: 'element_id')
  final String elementId;

  @JsonKey(name: 'set_num')
  final String setNum;

  final RebrickablePartDetailModel part;
  final RebrickableColorDetailModel color;

  RebrickableSetPartModel({
    required this.id,
    required this.quantity,
    required this.isSpare,
    required this.elementId,
    required this.setNum,
    required this.part,
    required this.color,
  });

  factory RebrickableSetPartModel.fromJson(Map<String, dynamic> json) => _$RebrickableSetPartModelFromJson(json);

  Map<String, dynamic> toJson() => _$RebrickableSetPartModelToJson(this);
}

@JsonSerializable()
class RebrickablePartDetailModel {
  @JsonKey(name: 'part_num')
  final String partNum;

  final String name;

  @JsonKey(name: 'part_cat_id')
  final int partCatId;

  @JsonKey(name: 'part_url')
  final String partUrl;

  @JsonKey(name: 'part_img_url')
  final String partImgUrl;

  RebrickablePartDetailModel({
    required this.partNum,
    required this.name,
    required this.partCatId,
    required this.partUrl,
    required this.partImgUrl,
  });

  factory RebrickablePartDetailModel.fromJson(Map<String, dynamic> json) => _$RebrickablePartDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$RebrickablePartDetailModelToJson(this);
}

@JsonSerializable()
class RebrickableColorDetailModel {
  final int id;
  final String name;
  final String rgb;

  @JsonKey(name: 'is_trans')
  final bool isTrans;

  RebrickableColorDetailModel({
    required this.id,
    required this.name,
    required this.rgb,
    required this.isTrans,
  });

  factory RebrickableColorDetailModel.fromJson(Map<String, dynamic> json) =>
      _$RebrickableColorDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$RebrickableColorDetailModelToJson(this);
}
