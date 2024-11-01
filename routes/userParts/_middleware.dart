import 'package:dart_frog/dart_frog.dart';
import 'package:dartomite/middleware/auth_middleware.dart';

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(authMiddleware);
}
