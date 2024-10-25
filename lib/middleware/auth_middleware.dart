import 'package:dart_frog/dart_frog.dart';
import 'package:supabase/supabase.dart';

Handler authMiddleware(Handler handler) {
  return (context) async {
    final supabaseClient = context.read<SupabaseClient>();
    final authorizationHeader = context.request.headers['Authorization'];

    if (authorizationHeader == null || !authorizationHeader.startsWith('Bearer ')) {
      return Response.json(body: {'error': 'Missing or invalid authorization header'}, statusCode: 401);
    }

    final token = authorizationHeader.substring(7); // Remove 'Bearer ' part
    final userResponse = await supabaseClient.auth.getUser(token);

    if (userResponse.user == null) {
      return Response.json(body: {'error': 'Invalid token'}, statusCode: 401);
    }

    return handler(context.provide<User>(() => userResponse.user!));
  };
}
