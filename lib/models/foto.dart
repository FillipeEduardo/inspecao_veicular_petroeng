import 'package:inspecao_veicular_petroeng/models/evidencia.dart';

class Foto {
  final String? id;
  final String nomeArquivo;
  final String extensao;
  final Evidencia evidencia;

  Foto({
    this.id,
    required this.nomeArquivo,
    required this.extensao,
    required this.evidencia,
  });
}
