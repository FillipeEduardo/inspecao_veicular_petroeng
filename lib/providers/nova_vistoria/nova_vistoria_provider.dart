import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/models/foto.dart';
import 'package:inspecao_veicular_petroeng/models/inspecao.dart';
import 'package:inspecao_veicular_petroeng/models/status_inspecao.dart';
import 'package:inspecao_veicular_petroeng/providers/nova_vistoria/nova_vistoria_state.dart';
import 'package:inspecao_veicular_petroeng/services/evidencia_service.dart';
import 'package:inspecao_veicular_petroeng/services/item_service.dart';

class NovaVistoriaNotifier extends AsyncNotifier<NovaVistoriaState> {
  @override
  Future<NovaVistoriaState> build() async {
    final apiResultItens = await ref.read(itemServiceProvider).todos();
    final apiResultEvidencias = await ref
        .read(evidenciaServiceProvider)
        .todos();
    NovaVistoriaState estadoInicial = NovaVistoriaState.initial();
    if (apiResultItens.dados == null || apiResultEvidencias.dados == null) {
      return estadoInicial;
    }
    estadoInicial = estadoInicial.copyWith(
      inspecoes: apiResultItens.dados!
          .map(
            (item) => Inspecao(
              item: item,
              status: StatusInspecao(id: 0, nome: "Pendente"),
            ),
          )
          .toList(),
      fotos: apiResultEvidencias.dados!
          .map((evidencia) => Foto(extensao: "", evidencia: evidencia))
          .toList(),
    );

    return estadoInicial;
  }

  void atualizar(NovaVistoriaState Function(NovaVistoriaState current) change) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(change(current));
  }
}

final novaVistoriaProvider =
    AsyncNotifierProvider<NovaVistoriaNotifier, NovaVistoriaState>(() {
      return NovaVistoriaNotifier();
    });
