import 'package:inspecao_veicular_petroeng/models/foto.dart';
import 'package:inspecao_veicular_petroeng/models/inspecao.dart';
import 'package:inspecao_veicular_petroeng/models/status_vistoria.dart';
import 'package:inspecao_veicular_petroeng/models/veiculo.dart';

class NovaVistoriaState {
  final int? id;
  final DateTime data;
  final double quilometragemVeiculo;
  final String? observacao;
  final StatusVistoria status;
  final Veiculo veiculo;
  final List<Foto>? fotos;
  final List<Inspecao>? inspecoes;

  NovaVistoriaState({
    this.id,
    required this.data,
    required this.quilometragemVeiculo,
    required this.status,
    required this.veiculo,
    this.observacao,
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

  NovaVistoriaState copyWith({
    int? id,
    DateTime? data,
    double? quilometragemVeiculo,
    String? observacao,
    StatusVistoria? status,
    Veiculo? veiculo,
    List<Foto>? fotos,
    List<Inspecao>? inspecoes,
  }) {
    return NovaVistoriaState(
      id: id ?? this.id,
      data: data ?? this.data,
      quilometragemVeiculo: quilometragemVeiculo ?? this.quilometragemVeiculo,
      observacao: observacao ?? this.observacao,
      status: status ?? this.status,
      veiculo: veiculo ?? this.veiculo,
      fotos: fotos ?? this.fotos,
      inspecoes: inspecoes ?? this.inspecoes,
    );
  }
}
