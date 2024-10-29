import 'package:dart_frog/dart_frog.dart';
import 'package:dartomite/database/database.dart';
import 'package:dartomite/repositories/group_repository.dart';
import 'package:dartomite/repositories/user_group_repository.dart';
import 'package:dartomite/repositories/user_repository.dart';
import 'package:dartomite/repositories/user_sets_repository.dart';
import 'package:dartomite/services/group_service.dart';
import 'package:dartomite/services/user_group_service.dart';
import 'package:dartomite/services/user_service.dart';
import 'package:dotenv/dotenv.dart';
import 'package:supabase/supabase.dart';

// Use singleton instances of repositories and services to reduce instantiation overhead
final env = DotEnv()..load();
final supabaseClient = SupabaseClient(
  env['SUPABASE_PROJECT_URL']!,
  env['SUPABASE_SERVICE_ROLE_KEY']!,
  authOptions: const AuthClientOptions(
    authFlowType: AuthFlowType.implicit,
  ),
);

final userSetsRepository = UserSetsRepository(supabaseClient);

// Local DB
final db = AppDatabase();
final userRepository = UserRepository(db);
final groupRepository = GroupRepository(db);
final userGroupRepository = UserGroupRepository(db);

final userService = UserService(userRepository, userGroupRepository);
final userGroupService = UserGroupService(userGroupRepository);
final groupService = GroupService(groupRepository);

Handler middleware(Handler handler) {
  return handler
      .use(provider<UserService>((context) => userService))
      .use(provider<UserGroupService>((context) => userGroupService))
      .use(provider<GroupService>((context) => groupService))
      .use(provider<UserRepository>((context) => userRepository))
      .use(provider<UserGroupRepository>((context) => userGroupRepository))
      .use(provider<GroupRepository>((context) => groupRepository))
      .use(provider<AppDatabase>((context) => db))
      .use(provider<UserSetsRepository>((context) => userSetsRepository))
      .use(provider<SupabaseClient>((context) => supabaseClient));
}
