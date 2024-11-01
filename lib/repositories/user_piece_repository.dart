import 'package:dartomite/dtos/bricklayer/rebrickable_part_dto.dart';
import 'package:dartomite/dtos/bricklayer/requests/update_user_piece_request.dart';
import 'package:dartomite/dtos/bricklayer/user_piece_dto.dart';
import 'package:supabase/supabase.dart';
import 'package:uuid/uuid.dart';

class UserPieceRepository {
  final SupabaseClient _supabaseClient;

  UserPieceRepository(this._supabaseClient);

  Future<List<UserPieceDto>> getPiecesByUserId(UuidValue userId) async {
    final data = await _supabaseClient.from('user_pieces').select().eq('user_id', userId.toString());

    return data.map((data) {
      return UserPieceDto(
        id: UuidValue.fromString(data['id'] as String),
        legoPartId: data['lego_part_id'] as String,
        name: data['name'] as String,
        quantity: data['count'] as int,
        inUseCount: data['in_use_count'] as int,
        imageUrl: data['imageUrl'] as String?,
        partUrl: data['partUrl'] as String?,
      );
    }).toList();
  }

  Future<UserPieceDto> getPieceById(UuidValue id, UuidValue userId) async {
    final data = await _supabaseClient
        .from('user_pieces')
        .select()
        .eq('id', id.toString())
        .eq('user_id', userId.toString())
        .single();

    return UserPieceDto(
      id: UuidValue.fromString(data['id'] as String),
      legoPartId: data['lego_part_id'] as String,
      name: data['name'] as String,
      quantity: data['count'] as int,
      inUseCount: data['in_use_count'] as int,
      imageUrl: data['imageUrl'] as String?,
      partUrl: data['partUrl'] as String?,
    );
  }

  Future<List<UserPieceDto>> createUserPieces(List<RebrickableSetPartDto> userPieces, UuidValue userId) async {
    final piecesToInsert = userPieces
        .map((piece) => {
              'user_id': userId.toString(),
              'lego_part_id': piece.legoId,
              'name': piece.name,
              'count': piece.quantity,
              'in_use_count': 0,
              'imageUrl': piece.imageUrl,
              'partUrl': piece.partUrl,
            })
        .toList();

    final data = await _supabaseClient.from('user_pieces').insert(piecesToInsert).select();
    return data.map((data) {
      return UserPieceDto(
        id: UuidValue.fromString(data['id'] as String),
        legoPartId: data['lego_part_id'] as String,
        name: data['name'] as String,
        quantity: data['count'] as int,
        inUseCount: data['in_use_count'] as int,
        imageUrl: data['imageUrl'] as String?,
        partUrl: data['partUrl'] as String?,
      );
    }).toList();
  }

  Future<UserPieceDto> addUserPiece(RebrickableSetPartDto userPiece, UuidValue userId) async {
    final pieceToInsert = {
      'lego_part_id': userPiece.legoId,
      'name': userPiece.name,
      'count': userPiece.quantity,
      'in_use_count': 0,
      'imageUrl': userPiece.imageUrl,
      'partUrl': userPiece.partUrl,
    };

    final data = await _supabaseClient.from('user_pieces').insert(pieceToInsert).single();

    return UserPieceDto(
      id: UuidValue.fromString(data['id'] as String),
      legoPartId: data['lego_part_id'] as String,
      name: data['name'] as String,
      quantity: data['count'] as int,
      inUseCount: data['in_use_count'] as int,
      imageUrl: data['imageUrl'] as String?,
      partUrl: data['partUrl'] as String?,
    );
  }

  Future<UserPieceDto> updateUserPiece(UpdateUserPieceRequest userPiece, UuidValue userId) async {
    final data = await _supabaseClient
        .from('user_pieces')
        .update({
          'lego_part_id': userPiece.legoPartId,
          'name': userPiece.name,
          'count': userPiece.quantity,
          'in_use_count': userPiece.inUseCount,
          'imageUrl': userPiece.imageUrl,
          'partUrl': userPiece.partUrl,
        })
        .eq('id', userPiece.id)
        .select()
        .single();

    return UserPieceDto(
      id: UuidValue.fromString(data['id'] as String),
      legoPartId: data['lego_part_id'] as String,
      name: data['name'] as String,
      quantity: data['count'] as int,
      inUseCount: data['in_use_count'] as int,
      imageUrl: data['imageUrl'] as String?,
      partUrl: data['partUrl'] as String?,
    );
  }

  Future<bool> deleteUserPiece(UuidValue pieceId, UuidValue userId) async {
    final data = await _supabaseClient
        .from('user_pieces')
        .delete()
        .eq('id', pieceId.toString())
        .eq('user_id', userId.toString())
        .select();

    return data.isNotEmpty;
  }
}
