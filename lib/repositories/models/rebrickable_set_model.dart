import 'package:json_annotation/json_annotation.dart';

part 'rebrickable_set_model.g.dart';

@JsonSerializable()
class RebrickableSetModel {
  final String setNum;
  final String name;
  final int year;
  final int themeId;
  final int numParts;
  final String setImgUrl;
  final String setUrl;
  final DateTime lastModifiedDt;

  RebrickableSetModel({
    required this.setNum,
    required this.name,
    required this.year,
    required this.themeId,
    required this.numParts,
    required this.setImgUrl,
    required this.setUrl,
    required this.lastModifiedDt,
  });

  factory RebrickableSetModel.fromJson(Map<String, dynamic> json) => _$RebrickableSetModelFromJson(json);

  Map<String, dynamic> toJson() => _$RebrickableSetModelToJson(this);
}
