import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/providers/lista_vistoria/lista_vistoria_state.dart';
import 'package:inspecao_veicular_petroeng/providers/services/vistoria_service_provider.dart';
import 'package:inspecao_veicular_petroeng/services/vistoria_service.dart';

class ListaVistoriaNotifier extends Notifier<ListaVistoriaState> {
  VistoriaService get _service => ref.read(vistoriaServiceProvider);

  @override
  ListaVistoriaState build() {
    return ListaVistoriaState.initial();
  }

  Future<void> loadVistorias({int statusId = 1}) async {
    try {
      state = ListaVistoriaState.initial(statusId: statusId);

      final vistorias = await _service.obterVistoriasPorUsuario(1, statusId);

      state = state.copyWith(
        vistorias: vistorias,
        currentPage: 1,
        hasMore: vistorias.length >= 10,
      );
    } catch (e) {
      state = ListaVistoriaState.initial(statusId: statusId);
      rethrow;
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    try {
      state = state.copyWith(isLoadingMore: true);

      final nextPage = state.currentPage + 1;
      final novasVistorias = await _service.obterVistoriasPorUsuario(
        nextPage,
        state.statusId,
      );

      state = state.copyWith(
        vistorias: [...state.vistorias, ...novasVistorias],
        currentPage: nextPage,
        hasMore: novasVistorias.length >= 10,
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false);
      rethrow;
    }
  }

  Future<void> changeStatusFilter(int statusId) async {
    if (state.statusId == statusId) return;
    await loadVistorias(statusId: statusId);
  }
}

final listaVistoriaProvider =
    NotifierProvider<ListaVistoriaNotifier, ListaVistoriaState>(() {
      return ListaVistoriaNotifier();
    });
