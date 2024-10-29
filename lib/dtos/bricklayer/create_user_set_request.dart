import 'package:json_annotation/json_annotation.dart';

part 'create_user_set_request.g.dart';

@JsonSerializable()
class CreateUserSetRequest {
  final String? setId;
  final String? brand;
  final String name;
  final bool currentlyBuilt;
  final String? setUrl;
  final String? imageUrl;
  final String? instructionsUrl;

  CreateUserSetRequest(
      {required this.name,
      required this.currentlyBuilt,
      this.setId,
      this.brand,
      this.setUrl,
      this.imageUrl,
      this.instructionsUrl});

  factory CreateUserSetRequest.fromJson(Map<String, dynamic> json) => _$CreateUserSetRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserSetRequestToJson(this);
}
