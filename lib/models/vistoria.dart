import 'package:inspecao_veicular_petroeng/models/veiculo.dart';

class Vistoria {
  int id;
  final DateTime data;
  final double quilometragemVeiculo;
  final Veiculo veiculo;

  Vistoria({
    required this.id,
    required this.data,
    required this.veiculo,
    required this.quilometragemVeiculo,
  });
}
