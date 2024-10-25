import 'dart:async';
import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:dartomite/dtos/groups/update_group_dto.dart';
import 'package:dartomite/services/group_service.dart';

Future<Response> onRequest(RequestContext context, int id) async {
  final groupService = context.read<GroupService>();

  switch (context.request.method) {
    case HttpMethod.get:
      return _getGroup(context, id, groupService);
    case HttpMethod.put:
      return _updateGroup(context, id, groupService);
    case HttpMethod.delete:
      return _deleteGroup(context, id, groupService);
    default:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _getGroup(RequestContext context, int id, GroupService groupService) async {
  final group = await groupService.getGroupById(id);

  if (group == null) {
    return Response(statusCode: HttpStatus.notFound);
  }

  return Response.json(body: group.toJson());
}

Future<Response> _updateGroup(RequestContext context, int id, GroupService groupService) async {
  final requestData = await context.request.json() as Map<String, dynamic>;
  final updateGroupDto = UpdateGroupDto.fromJson(requestData);

  await groupService.updateGroup(id, updateGroupDto);

  return Response(statusCode: HttpStatus.noContent);
}

Future<Response> _deleteGroup(RequestContext context, int id, GroupService groupService) async {
  await groupService.deleteGroup(id);
  return Response(statusCode: HttpStatus.noContent);
}
