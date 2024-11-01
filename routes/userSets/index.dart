import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dartomite/dtos/bricklayer/requests/create_user_set_request.dart';
import 'package:dartomite/dtos/bricklayer/responses/create_user_set_response.dart';
import 'package:dartomite/services/bricklayer/user_set_service.dart';
import 'package:dartomite/utils/session_user.dart';

Future<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _getAllUserSets(context);
    case HttpMethod.post:
      return _createUserSet(context);
    default:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _getAllUserSets(RequestContext context) async {
  final user = context.read<SessionUser>();
  final userSetsService = context.read<UserSetService>();

  final userSets = await userSetsService.getSetsByUserId(user.id);
  return Response.json(body: userSets.map((set) => set.toJson()).toList());
}

Future<Response> _createUserSet(RequestContext context) async {
  try {
    final user = context.read<SessionUser>();
    final userSetsService = context.read<UserSetService>();

    final body = await context.request.json() as Map<String, dynamic>;
    final createUserSetRequest = CreateUserSetRequest.fromJson(body);

    final userSet = await userSetsService.createUserSet(createUserSetRequest, user.id);

    return Response.json(body: CreateUserSetResponse(setInfo: userSet.item1, setPieces: userSet.item2).toJson());
  } catch (e) {
    return Response.json(
      body: {'error': 'Failed to create user set.'},
      statusCode: 500,
    );
  }
}
