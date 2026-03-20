import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/helpers/urls.dart';
import 'package:inspecao_veicular_petroeng/models/evidencia.dart';
import 'package:inspecao_veicular_petroeng/models/success_api_result.dart';
import 'package:inspecao_veicular_petroeng/interceptors/auth_interceptor.dart';

class EvidenciaService {
  final Dio _dio;

  EvidenciaService(this._dio);

  Future<List<Evidencia>> todos() async {
    try {
      final response = await _dio.get("/evidencia");
      final result = SuccessApiResult.fromJson(
        response.data,
        (dados) => (dados as List)
            .map((evidencia) => Evidencia.fromJson(evidencia))
            .toList(),
      );
      return result.dados;
    } catch (_) {
      return [];
    }
  }
}

final evidenciaServiceProvider = Provider<EvidenciaService>((ref) {
  final dio = Dio(BaseOptions(baseUrl: Urls.apiBaseUrl));
  dio.interceptors.add(AuthInterceptor(ref));
  return EvidenciaService(dio);
});
