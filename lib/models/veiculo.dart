import 'package:inspecao_veicular_petroeng/models/vistoria.dart';

class Veiculo {
  int id;
  String placa;
  int ano;
  String modelo;
  Vistoria? ultimaVistoria;

  Veiculo({
    required this.ano,
    required this.id,
    required this.modelo,
    required this.placa,
    this.ultimaVistoria,
  });

  factory Veiculo.fromJson(Map<String, dynamic> json) {
    return Veiculo(
      ano: json["ano"],
      id: json["id"],
      modelo: json["modelo"],
      placa: json["placa"],
      ultimaVistoria: json["ultimaVistoria"],
    );
  }
}
