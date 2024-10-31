import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:dartomite/services/supabase_service.dart';
import 'package:supabase/supabase.dart' as supabase;

Future<Response> onRequest(RequestContext context) async {
  final supabaseClient = context.read<supabase.SupabaseClient>();

  switch (context.request.method) {
    case HttpMethod.post:
      return _registerUser(context, supabaseClient);
    default:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _registerUser(RequestContext context, supabase.SupabaseClient client) async {
  final supabaseService = context.read<SupabaseService>();
  final body = await context.request.json() as Map<String, dynamic>;

  final email = body['email'] as String;
  final password = body['password'] as String;

  final userDto = await supabaseService.registerUser(email, password);

  if (userDto == null) {
    return Response.json(
      body: {'error': 'Signup failed.'},
      statusCode: 400,
    );
  }

  return Response.json(
    body: userDto.toJson(),
  );
}
