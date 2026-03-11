import 'package:dio/dio.dart';
import 'package:inspecao_veicular_petroeng/models/status_inspecao.dart';
import 'package:inspecao_veicular_petroeng/models/success_api_result.dart';

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
