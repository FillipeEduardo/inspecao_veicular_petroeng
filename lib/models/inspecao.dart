import 'package:inspecao_veicular_petroeng/models/item.dart';
import 'package:inspecao_veicular_petroeng/models/status_inspecao.dart';

class Inspecao {
  final int? id;
  final String? observacao;
  final Item item;
  final StatusInspecao status;

  Inspecao({
    this.id,
    required this.item,
    required this.status,
    this.observacao,
  });
}
