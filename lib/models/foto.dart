import 'package:image_picker/image_picker.dart';
import 'package:inspecao_veicular_petroeng/models/evidencia.dart';

class Foto {
  final String? id;
  final String nomeArquivo;
  final String extensao;
  final Evidencia evidencia;
  final XFile? file;

  Foto({
    this.id,
    required this.nomeArquivo,
    required this.extensao,
    required this.evidencia,
    this.file,
  });
}
