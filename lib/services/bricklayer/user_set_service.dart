import 'package:dartomite/dtos/bricklayer/requests/create_user_set_request.dart';
import 'package:dartomite/dtos/bricklayer/user_set_dto.dart';
import 'package:dartomite/repositories/rebrickable_repository.dart';
import 'package:dartomite/repositories/user_set_repository.dart';
import 'package:dartomite/utils/string_utils.dart';
import 'package:uuid/uuid.dart';

class UserSetService {
  final UserSetRepository _userSetRepository;
  final RebrickableRepository _rebrickableRepository;

  UserSetService({required UserSetRepository userSetRepository, required RebrickableRepository rebrickableRepository})
      : _userSetRepository = userSetRepository,
        _rebrickableRepository = rebrickableRepository;

  Future<UserSetDto> getSetById(UuidValue setId, UuidValue userId) async {
    return _userSetRepository.getSetById(setId, userId);
  }

  Future<List<UserSetDto>> getSetsByUserId(UuidValue userId) async {
    return _userSetRepository.getSetsByUserId(userId);
  }

  Future<UserSetDto> createUserSet(CreateUserSetRequest userSet, UuidValue userId) async {
    var userSetTmp = userSet;
    if (userSet.brand != null && userSet.brand!.equalsIgnoreCase('lego')) {
      userSetTmp = await _getLegoSetInfo(userSet);
    }

    return _userSetRepository.createUserSet(userSetTmp, userId);
  }

  Future<CreateUserSetRequest> _getLegoSetInfo(CreateUserSetRequest userSet) async {
    final setInfo = await _rebrickableRepository.getSetInfo('${userSet.setId!}-1');
    return userSet.copyWith(setUrl: setInfo.setUrl, imageUrl: setInfo.imgUrl);
  }
}
