import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/helpers/urls.dart';
import 'package:inspecao_veicular_petroeng/models/list_result.dart';
import 'package:inspecao_veicular_petroeng/models/success_api_result.dart';
import 'package:inspecao_veicular_petroeng/models/vistoria.dart';
import 'package:inspecao_veicular_petroeng/providers/nova_vistoria/nova_vistoria_state.dart';
import 'package:inspecao_veicular_petroeng/interceptors/auth_interceptor.dart';

class VistoriaService {
  final Dio _dio;

  VistoriaService(this._dio);

  Future<ListResult<Vistoria>?> obterVistoriasPorUsuario(int pagina) async {
    try {
      final response = await _dio.get(
        "/vistoria",
        queryParameters: {"Pagina": pagina},
      );
      final result = ListResult.fromJson(response.data, (dados) {
        return (dados as List)
            .map((vistoria) => Vistoria.fromJson(vistoria))
            .toList();
      });
      return result;
    } catch (ex) {
      return null;
    }
  }

  Future<int?> criar(NovaVistoriaState novaVistoria) async {
    try {
      final response = await _dio.post(
        "/vistoria",
        data: {
          "data": novaVistoria.data.toUtc().toIso8601String(),
          "quilometragemVeiculo": novaVistoria.quilometragemVeiculo,
          "veiculoId": novaVistoria.veiculo.id,
          "inspecoes":
              novaVistoria.inspecoes?.map((inspecao) {
                return {
                  "observacao": inspecao.observacao,
                  "statusId": inspecao.status.id,
                  "itemId": inspecao.item.id,
                };
              }).toList() ??
              [],
        },
      );
      final result = SuccessApiResult.fromJson(
        response.data,
        (dados) => dados as int,
      );
      return result.dados;
    } catch (_) {
      return null;
    }
  }

  Future<bool> criarFoto(
    String pathFile,
    int vistoriaId,
    int evidenciaId,
  ) async {
    try {
      final formData = FormData.fromMap({
        "vistoriaId": vistoriaId,
        "evidenciaId": evidenciaId,
        "foto": await MultipartFile.fromFile(pathFile),
      });
      final response = await _dio.post("/foto", data: formData);
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}

final vistoriaServiceProvider = Provider<VistoriaService>((ref) {
  final dio = Dio(BaseOptions(baseUrl: Urls.apiBaseUrl));
  dio.interceptors.add(AuthInterceptor(ref));
  return VistoriaService(dio);
});
