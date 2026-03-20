import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/helpers/urls.dart';
import 'package:inspecao_veicular_petroeng/models/success_api_result.dart';
import 'package:inspecao_veicular_petroeng/models/veiculo.dart';
import 'package:inspecao_veicular_petroeng/interceptors/auth_interceptor.dart';

class VeiculoService {
  final Dio _dio;

  VeiculoService(this._dio);

  Future<List<Veiculo>?> todos() async {
    try {
      final response = await _dio.get("/veiculo");
      final result = SuccessApiResult<List<Veiculo>>.fromJson(
        response.data,
        (dados) => (dados as List).map((x) => Veiculo.fromJson(x)).toList(),
      );
      return result.dados;
    } catch (_) {
      return null;
    }
  }

  Future<num?> criar(Map<String, dynamic> veiculo) async {
    try {
      final response = await _dio.post("/veiculo", data: veiculo);
      final result = SuccessApiResult.fromJson(
        response.data,
        (dados) => dados as num,
      );
      return result.dados;
    } catch (_) {
      return null;
    }
  }
}

final veiculoServiceProvider = Provider<VeiculoService>((ref) {
  final dio = Dio(BaseOptions(baseUrl: Urls.apiBaseUrl));
  dio.interceptors.add(AuthInterceptor(ref));
  return VeiculoService(dio);
});
