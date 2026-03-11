import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/models/foto.dart';
import 'package:inspecao_veicular_petroeng/models/inspecao.dart';
import 'package:inspecao_veicular_petroeng/models/status_inspecao.dart';
import 'package:inspecao_veicular_petroeng/providers/nova_vistoria/nova_vistoria_state.dart';
import 'package:inspecao_veicular_petroeng/providers/services/evidencia_service_provider.dart';
import 'package:inspecao_veicular_petroeng/providers/services/item_service_provider.dart';

class NovaVistoriaNotifier extends AsyncNotifier<NovaVistoriaState> {
  @override
  Future<NovaVistoriaState> build() async {
    final itens = await ref.read(itemServiceProvider).todos();
    final evidencias = await ref.read(evidenciaServiceProvider).todos();
    NovaVistoriaState estadoInicial = NovaVistoriaState.initial();
    estadoInicial = estadoInicial.copyWith(
      inspecoes: itens
          .map(
            (item) => Inspecao(
              item: item,
              status: StatusInspecao(id: 0, nome: "Pendente"),
            ),
          )
          .toList(),
      fotos: evidencias
          .map(
            (evidencia) =>
                Foto(nomeArquivo: "", extensao: "", evidencia: evidencia),
          )
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
