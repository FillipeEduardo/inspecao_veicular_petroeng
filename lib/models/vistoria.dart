import 'package:inspecao_veicular_petroeng/models/veiculo.dart';

class Vistoria {
  int id;
  final String data;
  final double quilometragemVeiculo;
  final Veiculo? veiculo;

  Vistoria({
    required this.id,
    required this.data,
    required this.veiculo,
    required this.quilometragemVeiculo,
  });

  factory Vistoria.fromJson(Map<String, dynamic> json) {
    return Vistoria(
      id: json["id"] as int,
      data: json["data"] as String,
      veiculo: json["veiculo"] != null
          ? Veiculo.fromJson(json["veiculo"] as Map<String, dynamic>)
          : null,
      quilometragemVeiculo: (json["quilometragemVeiculo"] as num).toDouble(),
    );
  }
}
