import 'package:dio/dio.dart';
import 'package:inspecao_veicular_petroeng/models/vistoria.dart';
import 'package:inspecao_veicular_petroeng/models/status_vistoria.dart';
import 'package:inspecao_veicular_petroeng/models/veiculo.dart';

class VistoriaService {
  Dio dio = Dio();

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
        status: StatusVistoria(
          id: statusId,
          nome: statusId == 1 ? "Em andamento" : "Concluída",
        ),
      );
      vistorias.add(vistoria);
    }
    return vistorias;
  }
}
