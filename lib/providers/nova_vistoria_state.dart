import 'package:inspecao_veicular_petroeng/models/foto.dart';
import 'package:inspecao_veicular_petroeng/models/inspecao.dart';
import 'package:inspecao_veicular_petroeng/models/status_vistoria.dart';
import 'package:inspecao_veicular_petroeng/models/veiculo.dart';

class NovaVistoriaState {
  final int? id;
  final DateTime data;
  final int quilometragemVeiculo;
  final String? observacao;
  final StatusVistoria status;
  final Veiculo veiculo;
  final List<Foto>? fotos;
  final List<Inspecao>? inspecoes;

  NovaVistoriaState({
    this.id,
    required this.data,
    required this.quilometragemVeiculo,
    this.observacao,
    required this.status,
    required this.veiculo,
    this.fotos,
    this.inspecoes,
  });

  factory NovaVistoriaState.initial() {
    return NovaVistoriaState(
      data: DateTime.now(),
      quilometragemVeiculo: 1,
      status: StatusVistoria(id: 1, nome: "Em andamento"),
      veiculo: Veiculo(ano: 2000, id: 1, modelo: "", placa: ""),
    );
  }
}
