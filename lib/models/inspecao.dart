import 'package:inspecao_veicular_petroeng/models/status_inspecao.dart';
import 'package:inspecao_veicular_petroeng/models/veiculo.dart';

class Inspecao {
  int id;
  DateTime dataInspecao;
  int statusId;
  StatusInspecao statusInspecao;
  Veiculo veiculo;

  Inspecao({
    required this.id,
    required this.dataInspecao,
    required this.statusId,
    required this.veiculo,
    required this.statusInspecao,
  });
}
