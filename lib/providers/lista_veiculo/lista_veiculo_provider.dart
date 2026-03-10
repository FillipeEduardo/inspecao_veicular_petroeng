import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/providers/lista_veiculo/lista_veiculo_state.dart';

class ListaVeiculoNotifier extends Notifier<ListaVeiculoState> {
  @override
  ListaVeiculoState build() {
    return ListaVeiculoState.initial();
  }

  void setState(ListaVeiculoState model) {
    state = model;
  }
}

final listaVeiculoProvider =
    NotifierProvider<ListaVeiculoNotifier, ListaVeiculoState>(() {
      return ListaVeiculoNotifier();
    });
