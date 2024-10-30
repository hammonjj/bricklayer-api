import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dartomite/repositories/user_set_repository.dart';
import 'package:supabase/supabase.dart' as supabase;

import 'package:uuid/uuid_value.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _getUserSetById(context, UuidValue.fromString(id));
    default:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _getUserSetById(RequestContext context, UuidValue setId) async {
  final user = context.read<supabase.User>();
  final userSetsRepository = context.read<UserSetRepository>();

  final userSet = await userSetsRepository.getSetById(setId, UuidValue.fromString(user.id));

  return Response.json(body: userSet.toJson());
}
