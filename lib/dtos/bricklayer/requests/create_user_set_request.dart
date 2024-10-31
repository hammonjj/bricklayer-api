import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_user_set_request.g.dart';

@CopyWith()
@JsonSerializable()
class CreateUserSetRequest {
  final bool currentlyBuilt;
  final int? pieces;
  final String? setId;
  final String? brand;
  final String? name;
  final String? setUrl;
  final String? imageUrl;
  final String? instructionsUrl;

  CreateUserSetRequest(
      {required this.currentlyBuilt,
      this.name,
      this.setId,
      this.brand,
      this.setUrl,
      this.imageUrl,
      this.instructionsUrl,
      this.pieces});

  factory CreateUserSetRequest.fromJson(Map<String, dynamic> json) => _$CreateUserSetRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserSetRequestToJson(this);
}
