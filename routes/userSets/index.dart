import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dartomite/dtos/bricklayer/requests/create_user_set_request.dart';
import 'package:dartomite/repositories/user_set_repository.dart';
import 'package:dartomite/utils/session_user.dart';
import 'package:mime/mime.dart';

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
  final userSetsRepository = context.read<UserSetRepository>();

  final userSets = await userSetsRepository.getSetsByUserId(user.id);

  return Response.json(body: userSets.map((set) => set.toJson()).toList());
}

Future<Response> _createUserSet(RequestContext context) async {
  final user = context.read<SessionUser>();
  final userSetsRepository = context.read<UserSetRepository>();

  final body = await context.request.json() as Map<String, dynamic>;
  final createUserSetRequest = CreateUserSetRequest.fromJson(body);

  final userSet = await userSetsRepository.createUserSet(createUserSetRequest, user.id);

  return Response.json(body: userSet.toJson());
}
