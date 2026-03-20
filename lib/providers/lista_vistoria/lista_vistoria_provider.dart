import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/providers/lista_vistoria/lista_vistoria_state.dart';
import 'package:inspecao_veicular_petroeng/services/vistoria_service.dart';

class ListaVistoriaNotifier extends Notifier<ListaVistoriaState> {
  VistoriaService get _service => ref.read(vistoriaServiceProvider);

  @override
  ListaVistoriaState build() {
    return ListaVistoriaState.initial();
  }

  Future<void> loadVistorias() async {
    try {
      state = ListaVistoriaState.initial();
      state = state.copyWith(isLoading: true);

      final listResultVistoria = await _service.obterVistoriasPorUsuario(1);

      if (listResultVistoria == null) return;

      state = state.copyWith(
        vistorias: listResultVistoria.dados.registros,
        currentPage: 1,
        hasMore:
            listResultVistoria.dados.registros.length >
            listResultVistoria.dados.totalDeRegistros,
        isLoading: false,
      );
    } catch (e) {
      state = ListaVistoriaState.initial();
      rethrow;
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    try {
      state = state.copyWith(isLoadingMore: true);

      final nextPage = state.currentPage + 1;
      final listResultVistoria = await _service.obterVistoriasPorUsuario(
        nextPage,
      );

      if (listResultVistoria == null) {
        state = state.copyWith(isLoadingMore: false);
        return;
      }

      final hasMore =
          state.vistorias.length + listResultVistoria.dados.registros.length <
          listResultVistoria.dados.totalDeRegistros;

      state = state.copyWith(
        vistorias: [...state.vistorias, ...listResultVistoria.dados.registros],
        currentPage: nextPage,
        hasMore: hasMore,
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false);
      rethrow;
    }
  }
}

final listaVistoriaProvider =
    NotifierProvider<ListaVistoriaNotifier, ListaVistoriaState>(() {
      return ListaVistoriaNotifier();
    });
