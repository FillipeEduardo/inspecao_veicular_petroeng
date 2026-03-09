import 'package:inspecao_veicular_petroeng/models/status_vistoria.dart';
import 'package:inspecao_veicular_petroeng/models/veiculo.dart';

class Vistoria {
  final int id;
  final DateTime data;
  final StatusVistoria status;
  final Veiculo veiculo;
  final int quilometragem;

  Vistoria({
    required this.id,
    required this.data,
    required this.status,
    required this.veiculo,
    required this.quilometragem,
  });
}
