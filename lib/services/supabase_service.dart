import 'package:dartomite/dtos/users/user_dto.dart';
import 'package:dartomite/utils/session_user.dart';
import 'package:supabase/supabase.dart';
import 'package:uuid/uuid_value.dart';

class SupabaseService {
  final SupabaseClient _client;

  SupabaseService(this._client);

  Future<UserDto?> registerUser(String email, String password) async {
    final response = await _client.auth.signUp(email: email, password: password);

    if (response.session == null) {
      return null;
    }

    return UserDto(
      userId: response.user!.id,
      username: response.user!.email!,
      accessToken: response.session!.accessToken,
    );
  }

  Future<UserDto?> loginUser(String email, String password) async {
    final response = await _client.auth.signInWithPassword(email: email, password: password);

    if (response.session == null) {
      return null;
    }

    return UserDto(
      userId: response.user!.id,
      username: response.user!.email!,
      accessToken: response.session!.accessToken,
    );
  }

  Future<SessionUser?> getSessionUser(String token) async {
    final userResponse = await _client.auth.getUser(token);

    if (userResponse.user == null) {
      return null;
    }

    return SessionUser(
      id: UuidValue.fromString(userResponse.user!.id),
      username: userResponse.user!.email!,
    );
  }
}
