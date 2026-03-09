import 'package:inspecao_veicular_petroeng/models/status_vistoria.dart';
import 'package:inspecao_veicular_petroeng/models/veiculo.dart';

class Vistoria {
  int id;
  final DateTime data;
  final int quilometragemVeiculo;
  String? observacao;
  final StatusVistoria status;
  final Veiculo veiculo;

  Vistoria({
    required this.id,
    required this.data,
    required this.status,
    required this.veiculo,
    required this.quilometragemVeiculo,
    this.observacao,
  });
}
