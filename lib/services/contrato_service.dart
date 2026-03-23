import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/helpers/urls.dart';
import 'package:inspecao_veicular_petroeng/interceptors/auth_interceptor.dart';
import 'package:inspecao_veicular_petroeng/models/api_result.dart';
import 'package:inspecao_veicular_petroeng/models/contrato.dart';

class ContratoService {
  final Dio _dio;
  static const String pathContrato = "/contrato";

  ContratoService(this._dio);

  Future<Apiresult<List<Contrato>>> obterTodos() async {
    try {
      final response = await _dio.get(pathContrato);
      final result = Apiresult.fromJson(
        response.data,
        fromJsonT: (dados) {
          return (dados as List)
              .map((contrato) => Contrato.fromJson(contrato))
              .toList();
        },
      );
      return result;
    } on DioException catch (ex) {
      return Apiresult.fromJson(ex.response!.data);
    }
  }

  Future<Apiresult<int>> criar(Map<String, dynamic> contrato) async {
    try {
      final response = await _dio.post(pathContrato, data: contrato);
      final result = Apiresult.fromJson(
        response.data,
        fromJsonT: (dados) {
          return dados as int;
        },
      );
      return result;
    } on DioException catch (ex) {
      return Apiresult.fromJson(ex.response!.data);
    }
  }
}

final contratoServiceProvider = Provider<ContratoService>((ref) {
  final dio = Dio(BaseOptions(baseUrl: Urls.apiBaseUrl));
  dio.interceptors.add(AuthInterceptor(ref));
  return ContratoService(dio);
});
