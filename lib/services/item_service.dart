import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/helpers/urls.dart';
import 'package:inspecao_veicular_petroeng/models/api_result.dart';
import 'package:inspecao_veicular_petroeng/models/item.dart';
import 'package:inspecao_veicular_petroeng/interceptors/auth_interceptor.dart';

class ItemService {
  final Dio _dio;

  ItemService(this._dio);

  Future<Apiresult<List<Item>>> todos() async {
    try {
      final response = await _dio.get("/item");
      var result = Apiresult.fromJson(
        response.data,
        fromJsonT: (dados) =>
            (dados as List).map((x) => Item.fromJson(x)).toList(),
      );
      return result;
    } on DioException catch (ex) {
      return Apiresult.fromJson(ex.response!.data);
    }
  }
}

final itemServiceProvider = Provider<ItemService>((ref) {
  final dio = Dio(BaseOptions(baseUrl: Urls.apiBaseUrl));
  dio.interceptors.add(AuthInterceptor(ref));
  return ItemService(dio);
});
