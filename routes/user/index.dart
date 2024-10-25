import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dartomite/dtos/users/create_user_dto.dart';
import 'package:dartomite/exceptions/user_creation_exception.dart';
import 'package:dartomite/services/user_service.dart';

Future<Response> onRequest(RequestContext context) async {
  final userService = context.read<UserService>();

  switch (context.request.method) {
    case HttpMethod.get:
      return _getAllUsers(context, userService);
    case HttpMethod.post:
      return _createUser(context, userService);
    default:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _getAllUsers(RequestContext context, UserService userService) async {
  final users = await userService.getAllUsers();
  return Response.json(body: users.map((u) => u.toJson()).toList());
}

Future<Response> _createUser(RequestContext context, UserService userService) async {
  try {
    final requestData = await context.request.json() as Map<String, dynamic>;
    final createUserDto = CreateUserDto.fromJson(requestData);

    final newUser = await userService.createUser(createUserDto);

    return Response.json(
      statusCode: HttpStatus.created,
      body: newUser.toJson(),
    );
  } catch (e) {
    if (e is UserCreationException) {
      return Response(statusCode: HttpStatus.badRequest, body: e.toString());
    }
    return Response(statusCode: HttpStatus.internalServerError, body: 'Internal Server Error');
  }
}
