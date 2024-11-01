import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_user_piece_request.g.dart';

@CopyWith()
@JsonSerializable()
class CreateUserPieceRequest {
  String legoPartId;
  String name;
  int quantity;
  int inUseCount;

  CreateUserPieceRequest({
    required this.legoPartId,
    required this.name,
    required this.quantity,
    required this.inUseCount,
  });

  factory CreateUserPieceRequest.fromJson(Map<String, dynamic> json) => _$CreateUserPieceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserPieceRequestToJson(this);
}
