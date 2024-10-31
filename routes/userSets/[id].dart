import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dartomite/services/bricklayer/user_set_service.dart';
import 'package:dartomite/utils/session_user.dart';
import 'package:uuid/uuid_value.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _getUserSetById(context, UuidValue.fromString(id));
    default:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _getUserSetById(RequestContext context, UuidValue setId) async {
  final user = context.read<SessionUser>();
  final userSetsService = context.read<UserSetService>();

  final userSet = await userSetsService.getSetById(setId, user.id);
  return Response.json(body: userSet.toJson());
}
