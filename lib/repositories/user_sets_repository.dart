import 'package:dartomite/dtos/bricklayer/create_user_set_request.dart';
import 'package:dartomite/dtos/bricklayer/user_set_dto.dart';
import 'package:supabase/supabase.dart';
import 'package:uuid/uuid.dart';

class UserSetsRepository {
  final SupabaseClient _supabaseClient;

  UserSetsRepository(this._supabaseClient);

  Future<UserSetDto> createUserSet(CreateUserSetRequest userSet, Uuid userId) async {
    final data = await _supabaseClient.from('BrickLayer.user_sets').insert({
      'user_id': userId,
      'set_id': userSet.setId,
      'brand': userSet.brand,
      'name': userSet.name,
      'currently_built': userSet.currentlyBuilt,
      'set_url': userSet.setUrl,
      'image_url': userSet.imageUrl,
      'instructions_url': userSet.instructionsUrl,
    }).select();

    return UserSetDto(
      id: UuidValue.fromString(data.first['id'] as String),
      setId: data.first['set_id'] as String?,
      brand: data.first['brand'] as String?,
      name: data.first['name'] as String,
      currentlyBuilt: data.first['currently_built'] as bool,
      setUrl: data.first['set_url'] as String?,
      imageUrl: data.first['image_url'] as String?,
      instructionsUrl: data.first['instructions_url'] as String?,
    );
  }

  Future<List<UserSetDto>> getSetsByUserId(UuidValue userId) async {
    final data = await _supabaseClient
        .from('BrickLayer.user_sets')
        .select('id, user_id, set_id, brand, name, currently_built, set_url, image_url, instructions_url')
        .eq('user_id', userId);

    if (data.isEmpty) {
      return [];
    }

    return data
        .map((set) => UserSetDto(
              id: UuidValue.fromString(set['id'] as String),
              setId: set['set_id'] as String?,
              brand: set['brand'] as String?,
              name: set['name'] as String,
              currentlyBuilt: set['currently_built'] as bool,
              setUrl: set['set_url'] as String?,
              imageUrl: set['image_url'] as String?,
              instructionsUrl: set['instructions_url'] as String?,
            ))
        .toList();
  }

  Future<bool> deleteSetById(UuidValue setId) async {
    final data = await _supabaseClient.from('BrickLayer.user_sets').delete().eq('id', setId).select();
    return data.isNotEmpty;
  }
}
