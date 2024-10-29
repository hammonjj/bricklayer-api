import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dartomite/repositories/user_sets_repository.dart';
import 'package:supabase/supabase.dart' as supabase;

import 'package:uuid/uuid_value.dart';

Future<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _getAllUserSets(context);
    default:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _getAllUserSets(RequestContext context) async {
  final user = context.read<supabase.User>();
  final userSetsRepository = context.read<UserSetsRepository>();

  final userSets = await userSetsRepository.getSetsByUserId(UuidValue.fromString(user.id));

  return Response.json(body: userSets.map((set) => set.toJson()).toList());
}
