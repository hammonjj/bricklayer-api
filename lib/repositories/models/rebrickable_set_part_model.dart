import 'package:json_annotation/json_annotation.dart';

part 'rebrickable_set_part_model.g.dart';

@JsonSerializable()
class RebrickableSetPartModel {
  final int id;
  final int quantity;
  final bool isSpare;
  final String elementId;
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
  final String partNum;
  final String name;
  final int partCatId;
  final String partUrl;
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
