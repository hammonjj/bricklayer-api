import 'dart:async';
import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:dartomite/dtos/users/update_user_dto.dart';
import 'package:dartomite/exceptions/user_update_exception.dart';
import 'package:dartomite/services/user_service.dart';

Future<Response> onRequest(RequestContext context, int id) async {
  final userService = context.read<UserService>();

  switch (context.request.method) {
    case HttpMethod.get:
      return _getUser(context, id, userService);
    case HttpMethod.put:
      return _updateUser(context, id, userService);
    case HttpMethod.delete:
      return _deleteUser(context, id, userService);
    default:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _getUser(RequestContext context, int id, UserService userService) async {
  final user = await userService.getUserById(id);

  if (user == null) {
    return Response(statusCode: HttpStatus.notFound);
  }

  return Response.json(body: user.toJson());
}

Future<Response> _updateUser(RequestContext context, int id, UserService userService) async {
  try {
    final requestData = await context.request.json() as Map<String, dynamic>;
    final updateUserDto = UpdateUserDto.fromJson(requestData);

    final updatedUser = await userService.updateUser(id, updateUserDto);

    if (updatedUser == null) {
      return Response(statusCode: HttpStatus.notFound);
    }

    return Response.json(body: updatedUser.toJson());
  } on UserUpdateException catch (e) {
    return Response(statusCode: HttpStatus.notFound, body: e.toString());
  }
}

Future<Response> _deleteUser(RequestContext context, int id, UserService userService) async {
  await userService.deleteUser(id);
  return Response(statusCode: HttpStatus.noContent);
}
