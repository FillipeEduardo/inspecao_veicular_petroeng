import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/helpers/urls.dart';
import 'package:inspecao_veicular_petroeng/models/api_result.dart';
import 'package:inspecao_veicular_petroeng/models/veiculo.dart';
import 'package:inspecao_veicular_petroeng/interceptors/auth_interceptor.dart';

class VeiculoService {
  final Dio _dio;

  VeiculoService(this._dio);

  Future<Apiresult<List<Veiculo>>> todos() async {
    try {
      final response = await _dio.get("/veiculo");
      final result = Apiresult.fromJson(
        response.data,
        fromJsonT: (dados) =>
            (dados as List).map((x) => Veiculo.fromJson(x)).toList(),
      );
      return result;
    } on DioException catch (ex) {
      return Apiresult.fromJson(ex.response!.data);
    }
  }

  Future<Apiresult<num>> criar(Map<String, dynamic> veiculo) async {
    try {
      final response = await _dio.post("/veiculo", data: veiculo);
      final result = Apiresult.fromJson(
        response.data,
        fromJsonT: (dados) => dados as num,
      );
      return result;
    } on DioException catch (ex) {
      return Apiresult.fromJson(ex.response!.data);
    }
  }
}

final veiculoServiceProvider = Provider<VeiculoService>((ref) {
  final dio = Dio(BaseOptions(baseUrl: Urls.apiBaseUrl));
  dio.interceptors.add(AuthInterceptor(ref));
  return VeiculoService(dio);
});
