import 'package:json_annotation/json_annotation.dart';

part 'rebrickable_set_model.g.dart';

@JsonSerializable()
class RebrickableSetModel {
  @JsonKey(name: 'set_num')
  final String setNum;
  final String name;
  final int year;
  @JsonKey(name: 'theme_id')
  final int themeId;
  @JsonKey(name: 'num_parts')
  final int numParts;
  @JsonKey(name: 'set_img_url')
  final String setImgUrl;
  @JsonKey(name: 'set_url')
  final String setUrl;
  @JsonKey(name: 'last_modified_dt')
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
