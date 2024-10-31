import 'dart:async';
import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:dartomite/services/supabase_service.dart';

Future<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.post:
      return _loginUser(context);
    default:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _loginUser(RequestContext context) async {
  final supabaseService = context.read<SupabaseService>();

  final body = await context.request.json() as Map<String, dynamic>;

  final email = body['email'] as String;
  final password = body['password'] as String;

  final userDto = await supabaseService.loginUser(email, password);

  if (userDto == null) {
    return Response.json(
      body: {'error': 'Login failed. Invalid credentials.'},
      statusCode: 400,
    );
  }

  return Response.json(
    body: userDto.toJson(),
  );
}
