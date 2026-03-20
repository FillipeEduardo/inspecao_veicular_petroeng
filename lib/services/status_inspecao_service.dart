import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/helpers/urls.dart';
import 'package:inspecao_veicular_petroeng/models/status_inspecao.dart';
import 'package:inspecao_veicular_petroeng/models/success_api_result.dart';
import 'package:inspecao_veicular_petroeng/interceptors/auth_interceptor.dart';

class StatusInspecaoService {
  final Dio dio;

  StatusInspecaoService(this.dio);

  Future<List<StatusInspecao>> todos() async {
    try {
      final response = await dio.get("/status-inspecao");
      final result = SuccessApiResult.fromJson(response.data, (dados) {
        return (dados as List)
            .map((statusInspecao) => StatusInspecao.fromJson(statusInspecao))
            .toList();
      });
      return result.dados;
    } catch (_) {
      return [];
    }
  }
}

final statusInspecaoServiceProvider = Provider<StatusInspecaoService>((ref) {
  final dio = Dio(BaseOptions(baseUrl: Urls.apiBaseUrl));
  dio.interceptors.add(AuthInterceptor(ref));
  return StatusInspecaoService(dio);
});
