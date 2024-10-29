import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

const Uuid _uuidGenerator = Uuid();

class UuidConverter implements JsonConverter<UuidValue?, String?> {
  const UuidConverter();

  @override
  UuidValue? fromJson(String? json) {
    return json != null ? UuidValue.fromString(json) : null;
  }

  @override
  String? toJson(UuidValue? object) => object?.toString();
}

class RequiredGuidConverter implements JsonConverter<UuidValue, String> {
  const RequiredGuidConverter();

  @override
  UuidValue fromJson(String? json) {
    return json != null ? UuidValue.fromString(json) : UuidValue.fromString(_uuidGenerator.v4());
  }

  @override
  String toJson(UuidValue object) => object.toString();
}
