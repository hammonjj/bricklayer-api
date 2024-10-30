import 'package:dartomite/repositories/models/rebrickable_set_part_model.dart';

class RebrickableSetPartDto {
  final String legoId;
  final int quantity;
  final String name;
  final String imageUrl;
  final String partUrl;

  const RebrickableSetPartDto({
    required this.legoId,
    required this.quantity,
    required this.name,
    required this.imageUrl,
    required this.partUrl,
  });

  factory RebrickableSetPartDto.fromModel(RebrickableSetPartModel model) {
    return RebrickableSetPartDto(
      legoId: model.part.partNum,
      quantity: model.quantity,
      name: model.part.name,
      imageUrl: model.part.partImgUrl,
      partUrl: model.part.partUrl,
    );
  }
}
