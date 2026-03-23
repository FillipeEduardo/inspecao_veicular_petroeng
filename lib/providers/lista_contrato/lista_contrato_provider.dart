import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/providers/lista_contrato/lista_contrato_state.dart';
import 'package:inspecao_veicular_petroeng/services/contrato_service.dart';

class ListaContratoNotifier extends Notifier<ListaContratoState> {
  ContratoService get _service => ref.read(contratoServiceProvider);
  @override
  ListaContratoState build() {
    return ListaContratoState.initial();
  }

  Future<void> load() async {
    state = state.copyWith(loading: true);
    final apiResult = await _service.obterTodos();
    if (apiResult.dados != null) {
      state = state.copyWith(contratos: apiResult.dados);
    }
    state = state.copyWith(loading: false);
  }
}

final listaContratoProvider =
    NotifierProvider<ListaContratoNotifier, ListaContratoState>(() {
      return ListaContratoNotifier();
    });
