import 'package:inspecao_veicular_petroeng/models/status_inspecao.dart';
import 'package:inspecao_veicular_petroeng/models/veiculo.dart';

class Inspecao {
  final int id;
  final DateTime dataInspecao;
  final int statusId;
  final StatusInspecao statusInspecao;
  final Veiculo veiculo;

  Inspecao({
    required this.id,
    required this.dataInspecao,
    required this.statusId,
    required this.veiculo,
    required this.statusInspecao,
  });
}
