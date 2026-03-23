import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/helpers/urls.dart';
import 'package:inspecao_veicular_petroeng/models/api_result.dart';
import 'package:inspecao_veicular_petroeng/models/evidencia.dart';
import 'package:inspecao_veicular_petroeng/interceptors/auth_interceptor.dart';

class EvidenciaService {
  final Dio _dio;

  EvidenciaService(this._dio);

  Future<Apiresult<List<Evidencia>>> todos() async {
    try {
      final response = await _dio.get("/evidencia");
      final result = Apiresult.fromJson(
        response.data,
        fromJsonT: (dados) => (dados as List)
            .map((evidencia) => Evidencia.fromJson(evidencia))
            .toList(),
      );
      return result;
    } on DioException catch (ex) {
      return Apiresult.fromJson(ex.response!.data);
    }
  }
}

final evidenciaServiceProvider = Provider<EvidenciaService>((ref) {
  final dio = Dio(BaseOptions(baseUrl: Urls.apiBaseUrl));
  dio.interceptors.add(AuthInterceptor(ref));
  return EvidenciaService(dio);
});
