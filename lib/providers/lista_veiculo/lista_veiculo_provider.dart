import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/providers/lista_veiculo/lista_veiculo_state.dart';
import 'package:inspecao_veicular_petroeng/providers/services/veiculo_service_provider.dart';
import 'package:inspecao_veicular_petroeng/services/veiculo_service.dart';

class ListaVeiculoNotifier extends Notifier<ListaVeiculoState> {
  VeiculoService get _service => ref.read(veiculoServiceProvider);
  @override
  ListaVeiculoState build() {
    return ListaVeiculoState.initial();
  }

  Future<void> load() async {
    if (state.isLoadingMore) return;
    state = state.copyWith(isLoadingMore: true);
    final veiculos = await _service.todos();
    if (veiculos != null && veiculos.isNotEmpty) {
      state = state.copyWith(veiculos: veiculos);
    }
    state = state.copyWith(isLoadingMore: false);
  }
}

final listaVeiculoProvider =
    NotifierProvider<ListaVeiculoNotifier, ListaVeiculoState>(() {
      return ListaVeiculoNotifier();
    });
