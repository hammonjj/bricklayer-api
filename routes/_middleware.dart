import 'package:dart_frog/dart_frog.dart';
import 'package:dartomite/database/database.dart';
import 'package:dartomite/repositories/group_repository.dart';
import 'package:dartomite/repositories/rebrickable_repository.dart';
import 'package:dartomite/repositories/user_group_repository.dart';
import 'package:dartomite/repositories/user_repository.dart';
import 'package:dartomite/repositories/user_set_repository.dart';
import 'package:dartomite/services/bricklayer/user_set_service.dart';
import 'package:dartomite/services/group_service.dart';
import 'package:dartomite/services/user_group_service.dart';
import 'package:dartomite/services/user_service.dart';
import 'package:dotenv/dotenv.dart';
import 'package:supabase/supabase.dart';

// Use singleton instances of repositories and services to reduce instantiation overhead
SupabaseClient? supabaseClient;
UserSetRepository? userSetRepository;
RebrickableRepository? rebrickableRepository;
UserSetService? userSetService;

// Local DB
final db = AppDatabase();
final userRepository = UserRepository(db);
final groupRepository = GroupRepository(db);
final userGroupRepository = UserGroupRepository(db);

final userService = UserService(userRepository, userGroupRepository);
final userGroupService = UserGroupService(userGroupRepository);
final groupService = GroupService(groupRepository);

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

  userSetRepository = UserSetRepository(supabaseClient!);
  rebrickableRepository = RebrickableRepository(env['REBRICKABLE_API_KEY']!);

  userSetService = UserSetService(userSetRepository: userSetRepository!, rebrickableRepository: rebrickableRepository!);

  return handler
      .use(provider<UserService>((context) => userService))
      .use(provider<UserGroupService>((context) => userGroupService))
      .use(provider<GroupService>((context) => groupService))
      .use(provider<UserRepository>((context) => userRepository))
      .use(provider<UserGroupRepository>((context) => userGroupRepository))
      .use(provider<GroupRepository>((context) => groupRepository))
      .use(provider<AppDatabase>((context) => db))
      .use(provider<UserSetService>((context) => userSetService!))
      .use(provider<UserSetRepository>((context) => userSetRepository!))
      .use(provider<RebrickableRepository>((context) => rebrickableRepository!))
      .use(provider<SupabaseClient>((context) => supabaseClient!));
}
