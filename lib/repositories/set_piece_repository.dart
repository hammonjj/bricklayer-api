import 'package:dartomite/dtos/bricklayer/set_piece_dto.dart';
import 'package:dartomite/dtos/bricklayer/user_piece_dto.dart';
import 'package:supabase/supabase.dart';
import 'package:uuid/uuid.dart';

class SetPieceRepository {
  final SupabaseClient _supabaseClient;

  SetPieceRepository(this._supabaseClient);

  Future<List<SetPieceDto>> getSetPieces(UuidValue setId) async {
    final data = await _supabaseClient.from('set_pieces').select().eq('id', setId.toString());

    return data.map((data) {
      return SetPieceDto.fromModelData(data);
    }).toList();
  }

  Future<List<SetPieceDto>> createSetPieces(List<UserPieceDto> setPieces, UuidValue setId) async {
    final piecesToInsert = setPieces
        .map((piece) => {
              'user_piece_id': piece.id.toString(),
              'user_set_id': setId.toString(),
              'count': piece.quantity,
            })
        .toList();

    final data = await _supabaseClient.from('set_pieces').insert(piecesToInsert).select();
    return data.map((data) {
      return SetPieceDto.fromModelData(data);
    }).toList();
  }

  Future<SetPieceDto> addSetPiece(UserPieceDto setPiece, UuidValue setId) async {
    final pieceToInsert = {
      'set_id': setId.toString(),
      'user_piece_id': setPiece.id.toString(),
      'user_set_id': setPiece.name,
      'count': setPiece.quantity,
    };

    final data = await _supabaseClient.from('set_pieces').insert(pieceToInsert).select().single();
    return SetPieceDto.fromModelData(data);
  }

  Future<SetPieceDto> updateSetPieceQuantity(String setId, String legoPartId, int quantity) async {
    final data = await _supabaseClient
        .from('set_pieces')
        .update({'quantity': quantity})
        .eq('set_id', setId)
        .eq('lego_part_id', legoPartId)
        .select()
        .single();

    return SetPieceDto.fromModelData(data);
  }

  Future<bool> deleteSetPiece(String setId, String legoPartId) async {
    final data =
        await _supabaseClient.from('set_pieces').delete().eq('set_id', setId).eq('lego_part_id', legoPartId).select();
    return data.isNotEmpty;
  }

  Future<bool> deleteSetPieces(String setId) async {
    final data = await _supabaseClient.from('set_pieces').delete().eq('set_id', setId).select();
    return data.isNotEmpty;
  }
}
