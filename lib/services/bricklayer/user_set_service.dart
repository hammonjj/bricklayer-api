import 'package:dartomite/dtos/bricklayer/rebrickable_part_dto.dart';
import 'package:dartomite/dtos/bricklayer/rebrickable_set_dto.dart';
import 'package:dartomite/dtos/bricklayer/requests/create_user_set_request.dart';
import 'package:dartomite/dtos/bricklayer/set_piece_dto.dart';
import 'package:dartomite/dtos/bricklayer/user_piece_dto.dart';
import 'package:dartomite/dtos/bricklayer/user_set_dto.dart';
import 'package:dartomite/repositories/rebrickable_repository.dart';
import 'package:dartomite/repositories/set_piece_repository.dart';
import 'package:dartomite/repositories/user_piece_repository.dart';
import 'package:dartomite/repositories/user_set_repository.dart';
import 'package:dartomite/utils/string_utils.dart';
import 'package:tuple/tuple.dart';
import 'package:uuid/uuid.dart';

class UserSetService {
  final UserSetRepository _userSetRepository;
  final RebrickableRepository _rebrickableRepository;
  final UserPieceRepository _userPieceRepository;
  final SetPieceRepository _setPieceRepository;

  UserSetService(
      {required UserSetRepository userSetRepository,
      required RebrickableRepository rebrickableRepository,
      required UserPieceRepository userPieceRepository,
      required SetPieceRepository setPieceRepository})
      : _userSetRepository = userSetRepository,
        _rebrickableRepository = rebrickableRepository,
        _userPieceRepository = userPieceRepository,
        _setPieceRepository = setPieceRepository;

  Future<UserSetDto> getSetById(UuidValue setId, UuidValue userId) async {
    return _userSetRepository.getSetById(setId, userId);
  }

  Future<List<UserSetDto>> getSetsByUserId(UuidValue userId) async {
    return _userSetRepository.getSetsByUserId(userId);
  }

  Future<void> deleteUserSet(UuidValue setId, UuidValue userId) async {
    await _userSetRepository.deleteSetById(setId, userId);
  }

  Future<Tuple2<UserSetDto, List<SetPieceDto>>> createUserSet(CreateUserSetRequest userSet, UuidValue userId) async {
    var userSetTmp = userSet;
    var setPieces = <UserPieceDto>[];
    var rebrickableParts = <RebrickableSetPartDto>[];

    if (userSet.brand != null && userSet.brand!.equalsIgnoreCase('lego')) {
      final results = await Future.wait([
        _getLegoSetInfo(userSet),
        _getLegoSetParts('${userSet.setId}-1'),
      ]);

      final rebrickableSetDto = results[0] as RebrickableSetDto;

      userSetTmp = userSet.copyWith(
          name: rebrickableSetDto.name,
          pieces: rebrickableSetDto.numParts,
          setUrl: rebrickableSetDto.setUrl,
          imageUrl: rebrickableSetDto.imgUrl);

      rebrickableParts = results[1] as List<RebrickableSetPartDto>;
    }

    if (rebrickableParts.isNotEmpty) {
      setPieces = await _userPieceRepository.createUserPieces(rebrickableParts, userId);
    }

    final userSetDto = await _userSetRepository.createUserSet(userSetTmp, userId);
    final setPiecesDtoList = await _setPieceRepository.createSetPieces(setPieces, userSetDto.id);
    return Tuple2(userSetDto, setPiecesDtoList);
  }

  Future<RebrickableSetDto> _getLegoSetInfo(CreateUserSetRequest userSet) async {
    return _rebrickableRepository.getSetInfo('${userSet.setId!}-1');
  }

  Future<List<RebrickableSetPartDto>> _getLegoSetParts(String setId) async {
    return _rebrickableRepository.getSetParts(setId);
  }
}
