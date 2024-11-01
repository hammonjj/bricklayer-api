import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_user_piece_request.g.dart';

@CopyWith()
@JsonSerializable()
class UpdateUserPieceRequest {
  final String id;
  final String legoPartId;
  final String name;
  final int quantity;
  final int inUseCount;
  final String imageUrl;
  final String partUrl;

  UpdateUserPieceRequest({
    required this.id,
    required this.legoPartId,
    required this.name,
    required this.quantity,
    required this.inUseCount,
    required this.imageUrl,
    required this.partUrl,
  });

  factory UpdateUserPieceRequest.fromJson(Map<String, dynamic> json) => _$UpdateUserPieceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserPieceRequestToJson(this);
}
