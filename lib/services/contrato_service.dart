import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/helpers/urls.dart';
import 'package:inspecao_veicular_petroeng/models/contrato.dart';
import 'package:inspecao_veicular_petroeng/models/success_api_result.dart';
import 'package:inspecao_veicular_petroeng/providers/services/auth_interceptor.dart';

class ContratoService {
  final Dio _dio;

  ContratoService(this._dio);

  Future<List<Contrato>?> obterTodos() async {
    try {
      final response = await _dio.get("/contrato");
      final result = SuccessApiResult.fromJson(response.data, (dados) {
        return (dados as List)
            .map((contrato) => Contrato.fromJson(contrato))
            .toList();
      });
      return result.dados;
    } catch (_) {
      return null;
    }
  }
}

final contratoServiceProvider = Provider<ContratoService>((ref) {
  final dio = Dio(BaseOptions(baseUrl: Urls.apiBaseUrl));
  dio.interceptors.add(AuthInterceptor(ref));
  return ContratoService(dio);
});
