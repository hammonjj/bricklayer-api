import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dartomite/dtos/bricklayer/requests/create_user_piece_request.dart';
import 'package:dartomite/services/bricklayer/user_piece_service.dart';
import 'package:dartomite/utils/session_user.dart';

Future<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _getAllUserPieces(context);
    case HttpMethod.post:
      return _createUserPiece(context);
    default:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _getAllUserPieces(RequestContext context) async {
  final user = context.read<SessionUser>();
  final userPieceService = context.read<UserPieceService>();

  final userSets = await userPieceService.getPiecesByUserId(user.id);
  return Response.json(body: userSets.map((set) => set.toJson()).toList());
}

Future<Response> _createUserPiece(RequestContext context) async {
  try {
    final user = context.read<SessionUser>();
    final userPieceService = context.read<UserPieceService>();

    final body = await context.request.json() as Map<String, dynamic>;
    final createUserSetRequest = CreateUserPieceRequest.fromJson(body);

    final userPieces = await userPieceService.createUserPiecesFromRequest([createUserSetRequest], user.id);

    return Response.json(body: userPieces.map((userPiece) => userPiece.toJson()).toList());
  } catch (e) {
    return Response.json(
      body: {'error': 'Failed to create user set.'},
      statusCode: 500,
    );
  }
}
