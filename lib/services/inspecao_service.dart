import 'package:dio/dio.dart';
import 'package:inspecao_veicular_petroeng/models/inspecao.dart';
import 'package:inspecao_veicular_petroeng/models/status_inspecao.dart';
import 'package:inspecao_veicular_petroeng/models/veiculo.dart';

class InspecaoService {
  Dio dio = Dio();

  Future<List<Inspecao>> obterInspecoesPorUsuario(
    int page,
    int statusId,
  ) async {
    await Future.delayed(Duration(seconds: 1));
    List<Inspecao> inspecoes = [];

    for (var i = 1; i <= 10; i++) {
      var inspecao = Inspecao(
        id: i,
        dataInspecao: DateTime.now(),
        statusId: 1,
        veiculo: Veiculo(
          ano: 2025,
          id: 1,
          modelo: "Fiat argo",
          placa: "fdf-5465",
        ),
        statusInspecao: StatusInspecao(id: 1, nome: "Andamento"),
      );
      inspecoes.add(inspecao);
    }
    return inspecoes;
  }
}
