import 'dart:async';
import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:dartomite/dtos/groups/create_group_dto.dart';
import 'package:dartomite/services/group_service.dart';

Future<Response> onRequest(RequestContext context) async {
  final groupService = context.read<GroupService>();

  switch (context.request.method) {
    case HttpMethod.get:
      return _getAllGroups(context, groupService);
    case HttpMethod.post:
      return _createGroup(context, groupService);
    default:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _getAllGroups(RequestContext context, GroupService groupService) async {
  final groups = await groupService.getAllGroups();
  return Response.json(body: groups.map((g) => g.toJson()).toList());
}

Future<Response> _createGroup(RequestContext context, GroupService groupService) async {
  final requestData = await context.request.json() as Map<String, dynamic>;
  final createGroupDto = CreateGroupDto.fromJson(requestData);

  final newGroup = await groupService.createGroup(createGroupDto);

  return Response.json(
    statusCode: HttpStatus.created,
    body: newGroup.toJson(),
  );
}
