import 'dart:async';
import 'package:dart_frog/dart_frog.dart';
import 'package:supabase/supabase.dart';

Future<Response> onRequest(RequestContext context) async {
  final supabaseClient = context.read<SupabaseClient>();

  try {
    final body = await context.request.json() as Map<String, dynamic>;

    final email = body['email'] as String;
    final password = body['password'] as String;

    final response = await supabaseClient.auth.signInWithPassword(email: email, password: password);

    if (response.session == null) {
      return Response.json(
        body: {'error': 'Login failed. Invalid credentials.'},
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
      body: {'error': 'An error occurred during login: $e'},
      statusCode: 500,
    );
  }
}
