import 'dart:convert';
import 'dart:io';
import 'package:dartomite/dtos/bricklayer/rebrickable_part_dto.dart';
import 'package:dartomite/dtos/bricklayer/rebrickable_set_dto.dart';
import 'package:dartomite/repositories/models/rebrickable_set_model.dart';
import 'package:dartomite/repositories/models/rebrickable_set_part_model.dart';
import 'package:http/http.dart' as http;

class RebrickableRepository {
  final String apiKey;

  RebrickableRepository(this.apiKey);

  Future<RebrickableSetDto> getSetInfo(String setNum) async {
    final url = Uri.parse('https://rebrickable.com/api/v3/lego/sets/$setNum/');
    final response = await http.get(url, headers: _headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final model = RebrickableSetModel.fromJson(data);

      return RebrickableSetDto.fromModel(model);
    } else {
      throw const HttpException('Failed to load set info');
    }
  }

  Future<List<RebrickableSetPartDto>> getSetParts(String setNum, {int page = 1, int pageSize = 100}) async {
    final url = Uri.parse(
      'https://rebrickable.com/api/v3/lego/sets/$setNum/parts/?page=$page&page_size=$pageSize',
    );
    final response = await http.get(url, headers: _headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final rebrickablePartModels = (data['results'] as List)
          .map((json) => RebrickableSetPartModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return rebrickablePartModels.map(RebrickableSetPartDto.fromModel).toList();
    } else {
      throw const HttpException('Failed to load set parts');
    }
  }

  Map<String, String> get _headers => {
        'Authorization': 'key $apiKey',
        'Content-Type': 'application/json',
      };
}
