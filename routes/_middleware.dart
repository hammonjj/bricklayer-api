import 'package:dart_frog/dart_frog.dart';
import 'package:dartomite/repositories/rebrickable_repository.dart';
import 'package:dartomite/repositories/user_set_repository.dart';
import 'package:dartomite/services/bricklayer/user_set_service.dart';
import 'package:dartomite/services/supabase_service.dart';
import 'package:dotenv/dotenv.dart';
import 'package:supabase/supabase.dart';

SupabaseClient? supabaseClient;

Handler middleware(Handler handler) {
  final env = DotEnv()..load();

  supabaseClient = SupabaseClient(
    env['SUPABASE_PROJECT_URL']!,
    env['SUPABASE_SERVICE_ROLE_KEY']!,
    authOptions: const AuthClientOptions(
      authFlowType: AuthFlowType.implicit,
    ),
    postgrestOptions: const PostgrestClientOptions(schema: 'BrickLayer'),
  );

  final userSetRepository = UserSetRepository(supabaseClient!);
  final rebrickableRepository = RebrickableRepository(env['REBRICKABLE_API_KEY']!);

  return handler
      .use(provider<UserSetService>((context) =>
          UserSetService(userSetRepository: userSetRepository, rebrickableRepository: rebrickableRepository)))
      .use(provider<SupabaseService>((context) => SupabaseService(supabaseClient!)));
}
