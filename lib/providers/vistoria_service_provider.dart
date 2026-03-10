import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/services/vistoria_service.dart';

final vistoriaServiceProvider = Provider<VistoriaService>((ref) {
  return VistoriaService();
});
