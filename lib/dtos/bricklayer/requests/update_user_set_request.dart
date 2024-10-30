import 'package:json_annotation/json_annotation.dart';

part 'update_user_set_request.g.dart';

@JsonSerializable()
class UpdateUserSetRequest {
  final String? setId;
  final String? brand;
  final String name;
  final bool currentlyBuilt;
  final String? setUrl;
  final String? imageUrl;
  final String? instructionsUrl;

  UpdateUserSetRequest(
      {required this.name,
      required this.currentlyBuilt,
      this.setId,
      this.brand,
      this.setUrl,
      this.imageUrl,
      this.instructionsUrl});

  factory UpdateUserSetRequest.fromJson(Map<String, dynamic> json) => _$UpdateUserSetRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserSetRequestToJson(this);
}
