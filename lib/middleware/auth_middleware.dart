import 'package:dart_frog/dart_frog.dart';
import 'package:dartomite/utils/session_user.dart';
import 'package:supabase/supabase.dart';
import 'package:uuid/uuid.dart';

Handler authMiddleware(Handler handler) {
  return (context) async {
    final supabaseClient = context.read<SupabaseClient>();
    final authorizationHeader = context.request.headers['Authorization'];

    if (authorizationHeader == null || !authorizationHeader.startsWith('Bearer ')) {
      return Response.json(body: {'error': 'Missing or invalid authorization header'}, statusCode: 401);
    }

    final token = authorizationHeader.substring(7);
    final userResponse = await supabaseClient.auth.getUser(token);

    if (userResponse.user == null) {
      return Response.json(body: {'error': 'Invalid token'}, statusCode: 401);
    }

    final sessionUser = SessionUser(
      id: UuidValue.fromString(userResponse.user!.id),
      username: userResponse.user!.email!,
    );

    return handler(context.provide<SessionUser>(() => sessionUser));
  };
}
