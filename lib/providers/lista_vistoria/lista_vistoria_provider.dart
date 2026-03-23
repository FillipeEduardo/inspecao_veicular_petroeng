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

      final apiResult = await _service.obterVistoriasPorUsuario(1);

      if (apiResult.dados?.registros == null) {
        state = state.copyWith(isLoading: false);
        return;
      }

      state = state.copyWith(
        vistorias: apiResult.dados!.registros,
        currentPage: 1,
        hasMore:
            apiResult.dados!.registros.length >
            apiResult.dados!.totalDeRegistros,
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
      final apiResult = await _service.obterVistoriasPorUsuario(nextPage);

      if (apiResult.dados == null) {
        state = state.copyWith(isLoadingMore: false);
        return;
      }

      final hasMore =
          state.vistorias.length + apiResult.dados!.registros.length <
          apiResult.dados!.totalDeRegistros;

      state = state.copyWith(
        vistorias: [...state.vistorias, ...apiResult.dados!.registros],
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
