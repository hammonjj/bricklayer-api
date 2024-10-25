import 'dart:async';
import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:dartomite/dtos/user_groups/create_user_group_dto.dart';
import 'package:dartomite/services/user_group_service.dart';

Future<Response> onRequest(RequestContext context) async {
  final userGroupService = context.read<UserGroupService>();

  switch (context.request.method) {
    case HttpMethod.get:
      return _getAllUserGroups(context, userGroupService);
    case HttpMethod.post:
      return _createUserGroup(context, userGroupService);
    default:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _getAllUserGroups(RequestContext context, UserGroupService userGroupService) async {
  final userGroups = await userGroupService.getAllUserGroups();
  return Response.json(body: userGroups.map((ug) => ug.toJson()).toList());
}

Future<Response> _createUserGroup(RequestContext context, UserGroupService userGroupService) async {
  final requestData = await context.request.json() as Map<String, dynamic>;
  final createUserGroupDto = CreateUserGroupDto.fromJson(requestData);

  final newUserGroup = await userGroupService.createUserGroup(createUserGroupDto);

  return Response.json(
    statusCode: HttpStatus.created,
    body: newUserGroup.toJson(),
  );
}
