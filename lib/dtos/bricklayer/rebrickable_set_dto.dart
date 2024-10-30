import 'package:dartomite/repositories/models/rebrickable_set_model.dart';

class RebrickableSetDto {
  final String name;
  final String setNumber;
  final int year;
  final int themeId;
  final int numParts;
  final String imgUrl;
  final String setUrl;

  RebrickableSetDto({
    required this.name,
    required this.setNumber,
    required this.year,
    required this.themeId,
    required this.numParts,
    required this.imgUrl,
    required this.setUrl,
  });

  factory RebrickableSetDto.fromModel(RebrickableSetModel model) {
    return RebrickableSetDto(
      name: model.name,
      setNumber: model.setNum,
      year: model.year,
      themeId: model.themeId,
      numParts: model.numParts,
      imgUrl: model.setImgUrl,
      setUrl: model.setUrl,
    );
  }
}
