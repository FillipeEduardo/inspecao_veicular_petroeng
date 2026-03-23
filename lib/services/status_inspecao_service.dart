import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/helpers/urls.dart';
import 'package:inspecao_veicular_petroeng/models/api_result.dart';
import 'package:inspecao_veicular_petroeng/models/status_inspecao.dart';
import 'package:inspecao_veicular_petroeng/interceptors/auth_interceptor.dart';

class StatusInspecaoService {
  final Dio dio;

  StatusInspecaoService(this.dio);

  Future<Apiresult<List<StatusInspecao>>> todos() async {
    try {
      final response = await dio.get("/status-inspecao");
      final result = Apiresult.fromJson(
        response.data,
        fromJsonT: (dados) {
          return (dados as List)
              .map((statusInspecao) => StatusInspecao.fromJson(statusInspecao))
              .toList();
        },
      );
      return result;
    } on DioException catch (ex) {
      return Apiresult.fromJson(ex.response!.data);
    }
  }
}

final statusInspecaoServiceProvider = Provider<StatusInspecaoService>((ref) {
  final dio = Dio(BaseOptions(baseUrl: Urls.apiBaseUrl));
  dio.interceptors.add(AuthInterceptor(ref));
  return StatusInspecaoService(dio);
});
