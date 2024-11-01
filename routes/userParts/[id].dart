import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:dartomite/services/bricklayer/user_piece_service.dart';
import 'package:dartomite/utils/session_user.dart';
import 'package:uuid/uuid_value.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _getUserPieceById(context, UuidValue.fromString(id));
    case HttpMethod.delete:
      return _deleteUserPieceById(context, UuidValue.fromString(id));
    default:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _getUserPieceById(RequestContext context, UuidValue setId) async {
  final user = context.read<SessionUser>();
  final userPieceService = context.read<UserPieceService>();

  final userSet = await userPieceService.getPieceById(setId, user.id);
  return Response.json(body: userSet.toJson());
}

Future<Response> _deleteUserPieceById(RequestContext context, UuidValue setId) async {
  final user = context.read<SessionUser>();
  final userPieceService = context.read<UserPieceService>();

  await userPieceService.deletePieceById(setId, user.id);

  return Response();
}
