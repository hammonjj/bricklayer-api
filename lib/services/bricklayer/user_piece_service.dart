import 'package:dartomite/dtos/bricklayer/rebrickable_part_dto.dart';
import 'package:dartomite/dtos/bricklayer/requests/create_user_piece_request.dart';
import 'package:dartomite/dtos/bricklayer/user_piece_dto.dart';
import 'package:dartomite/repositories/user_piece_repository.dart';
import 'package:uuid/uuid.dart';

class UserPieceService {
  final UserPieceRepository _userPieceRepository;

  UserPieceService({required UserPieceRepository userPieceRepository}) : _userPieceRepository = userPieceRepository;

  Future<List<UserPieceDto>> createUserPieces(List<RebrickableSetPartDto> userPieces, UuidValue userId) async {
    return _userPieceRepository.createUserPieces(userPieces, userId);
  }

  Future<List<UserPieceDto>> createUserPiecesFromRequest(
      List<CreateUserPieceRequest> userPieces, UuidValue userId) async {
    // Call Rebrickable API to get part info then pass to repository
    //return _userPieceRepository.createUserPieces(userPieces, userId);
    return [];
  }

  // Future<UserPieceDto> update(UserPiece userPiece) async {
  //   return await _userPieceRepository.update(userPiece);
  // }

  Future<bool> deletePieceById(UuidValue id, UuidValue userId) async {
    return _userPieceRepository.deleteUserPiece(id, userId);
  }

  Future<List<UserPieceDto>> getPiecesByUserId(UuidValue userId) async {
    return _userPieceRepository.getPiecesByUserId(userId);
  }

  Future<UserPieceDto> getPieceById(UuidValue id, UuidValue userId) async {
    return _userPieceRepository.getPieceById(id, userId);
  }
}
