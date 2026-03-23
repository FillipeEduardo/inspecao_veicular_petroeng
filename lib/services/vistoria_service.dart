import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/helpers/urls.dart';
import 'package:inspecao_veicular_petroeng/models/api_result.dart';
import 'package:inspecao_veicular_petroeng/models/list_result.dart';
import 'package:inspecao_veicular_petroeng/models/vistoria.dart';
import 'package:inspecao_veicular_petroeng/providers/nova_vistoria/nova_vistoria_state.dart';
import 'package:inspecao_veicular_petroeng/interceptors/auth_interceptor.dart';

class VistoriaService {
  final Dio _dio;

  VistoriaService(this._dio);

  Future<Apiresult<ListResult<Vistoria>>> obterVistoriasPorUsuario(
    int pagina,
  ) async {
    try {
      final response = await _dio.get(
        "/vistoria",
        queryParameters: {"Pagina": pagina},
      );
      final result = Apiresult.fromJson(
        response.data,
        fromJsonT: (dados) {
          return ListResult.fromJson(dados as Map<String, dynamic>, (
            registros,
          ) {
            return (registros as List)
                .map((x) => Vistoria.fromJson(x))
                .toList();
          });
        },
      );
      return result;
    } on DioException catch (ex) {
      return Apiresult.fromJson(ex.response!.data);
    }
  }

  Future<Apiresult<num>> criar(NovaVistoriaState novaVistoria) async {
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
      final result = Apiresult.fromJson(
        response.data,
        fromJsonT: (dados) => dados as num,
      );
      return result;
    } on DioException catch (ex) {
      return Apiresult.fromJson(ex.response!.data);
    }
  }

  Future<Apiresult> criarFoto(
    String pathFile,
    num vistoriaId,
    num evidenciaId,
  ) async {
    try {
      final formData = FormData.fromMap({
        "vistoriaId": vistoriaId,
        "evidenciaId": evidenciaId,
        "foto": await MultipartFile.fromFile(pathFile),
      });
      final response = await _dio.post("/foto", data: formData);
      return Apiresult.fromJson(
        response.data,
        fromJsonT: (dados) => dados as dynamic,
      );
    } on DioException catch (ex) {
      return Apiresult.fromJson(ex.response!.data);
    }
  }
}

final vistoriaServiceProvider = Provider<VistoriaService>((ref) {
  final dio = Dio(BaseOptions(baseUrl: Urls.apiBaseUrl));
  dio.interceptors.add(AuthInterceptor(ref));
  return VistoriaService(dio);
});
