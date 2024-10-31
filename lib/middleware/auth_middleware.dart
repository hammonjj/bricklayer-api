import 'package:dart_frog/dart_frog.dart';
import 'package:dartomite/services/supabase_service.dart';
import 'package:dartomite/utils/session_user.dart';

Handler authMiddleware(Handler handler) {
  return (context) async {
    final authorizationHeader = context.request.headers['Authorization'];

    if (authorizationHeader == null || !authorizationHeader.startsWith('Bearer ')) {
      return Response.json(body: {'error': 'Missing or invalid authorization header'}, statusCode: 401);
    }

    final supabaseService = context.read<SupabaseService>();
    final sessionUser = await supabaseService.getSessionUser(authorizationHeader.substring(7));

    if (sessionUser == null) {
      return Response.json(body: {'error': 'Invalid token'}, statusCode: 401);
    }

    return handler(context.provide<SessionUser>(() => sessionUser));
  };
}
