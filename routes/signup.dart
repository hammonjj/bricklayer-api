import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
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

Future<Response> _registerUser(
  RequestContext context,
  supabase.SupabaseClient client,
) async {
  try {
    final body = await context.request.json() as Map<String, dynamic>;

    final email = body['email'] as String;
    final password = body['password'] as String;

    final response = await client.auth.signUp(email: email, password: password);

    if (response.session == null) {
      return Response.json(
        body: {'error': 'Signup failed.'},
        statusCode: 400,
      );
    }

    return Response.json(
      body: {
        'accessToken': response.session!.accessToken,
        'refreshToken': response.session!.refreshToken,
        'userId': response.user!.id,
        'username': response.user!.email
      },
    );
  } catch (e) {
    return Response.json(
      body: {'error': 'An error occurred during signup: $e'},
      statusCode: 500,
    );
  }
}
