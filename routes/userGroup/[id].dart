import 'dart:async';
import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:dartomite/dtos/user_groups/update_user_group_dto.dart';
import 'package:dartomite/services/user_group_service.dart';

Future<Response> onRequest(RequestContext context, int id) async {
  final userGroupService = context.read<UserGroupService>();

  switch (context.request.method) {
    case HttpMethod.get:
      return _getUserGroup(context, id, userGroupService);
    case HttpMethod.put:
      return _updateUserGroup(context, id, userGroupService);
    case HttpMethod.delete:
      return _deleteUserGroup(context, id, userGroupService);
    default:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _getUserGroup(RequestContext context, int id, UserGroupService userGroupService) async {
  final userGroup = await userGroupService.getUserGroupById(id);

  if (userGroup == null) {
    return Response(statusCode: HttpStatus.notFound);
  }

  return Response.json(body: userGroup.toJson());
}

Future<Response> _updateUserGroup(RequestContext context, int id, UserGroupService userGroupService) async {
  final requestData = await context.request.json() as Map<String, dynamic>;
  final updateUserGroupDto = UpdateUserGroupDto.fromJson(requestData);

  await userGroupService.updateUserGroup(id, updateUserGroupDto);

  return Response(statusCode: HttpStatus.noContent);
}

Future<Response> _deleteUserGroup(RequestContext context, int id, UserGroupService userGroupService) async {
  await userGroupService.deleteUserGroup(id);
  return Response(statusCode: HttpStatus.noContent);
}
