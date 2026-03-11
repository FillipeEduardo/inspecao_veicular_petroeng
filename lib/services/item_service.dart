import 'package:dio/dio.dart';
import 'package:inspecao_veicular_petroeng/models/item.dart';
import 'package:inspecao_veicular_petroeng/models/success_api_result.dart';

class ItemService {
  final Dio _dio;

  ItemService(this._dio);

  Future<List<Item>> todos() async {
    try {
      final response = await _dio.get("/item");
      var result = SuccessApiResult.fromJson(
        response.data,
        (dados) => (dados as List).map((x) => Item.fromJson(x)).toList(),
      );
      return result.dados;
    } catch (_) {
      return [];
    }
  }
}
