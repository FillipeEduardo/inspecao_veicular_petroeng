import 'package:dio/dio.dart';
import 'package:inspecao_veicular_petroeng/models/success_api_result.dart';
import 'package:inspecao_veicular_petroeng/models/vistoria.dart';
import 'package:inspecao_veicular_petroeng/models/veiculo.dart';
import 'package:inspecao_veicular_petroeng/providers/nova_vistoria/nova_vistoria_state.dart';

class VistoriaService {
  final Dio _dio;

  VistoriaService(this._dio);

  Future<List<Vistoria>> obterVistoriasPorUsuario(
    int page,
    int statusId,
  ) async {
    await Future.delayed(Duration(seconds: 1));
    List<Vistoria> vistorias = [];

    for (var i = 1; i <= 10; i++) {
      var vistoria = Vistoria(
        id: i,
        data: DateTime.now(),
        veiculo: Veiculo(
          ano: 2025,
          id: 1,
          modelo: "Fiat argo",
          placa: "fdf-5465",
        ),
        quilometragemVeiculo: 8000,
      );
      vistorias.add(vistoria);
    }
    return vistorias;
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
