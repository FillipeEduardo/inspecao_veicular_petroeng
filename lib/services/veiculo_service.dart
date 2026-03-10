import 'package:dio/dio.dart';
import 'package:inspecao_veicular_petroeng/models/success_api_result.dart';
import 'package:inspecao_veicular_petroeng/models/veiculo.dart';

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
}
