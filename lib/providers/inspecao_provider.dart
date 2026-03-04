import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/providers/inspecao_state.dart';
import 'package:inspecao_veicular_petroeng/services/inspecao_service.dart';

class InspecaoNotifier extends Notifier<InspecaoState> {
  InspecaoService get _service => ref.read(inspecaoServiceProvider);

  @override
  InspecaoState build() {
    return InspecaoState.initial();
  }

  Future<void> loadInspecoes({int statusId = 1}) async {
    try {
      state = InspecaoState.initial(statusId: statusId);

      final inspecoes = await _service.obterInspecoesPorUsuario(1, statusId);

      state = state.copyWith(
        inspecoes: inspecoes,
        currentPage: 1,
        hasMore: inspecoes.length >= 10,
      );
    } catch (e) {
      state = InspecaoState.initial(statusId: statusId);
      rethrow;
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    try {
      state = state.copyWith(isLoadingMore: true);

      final nextPage = state.currentPage + 1;
      final novasInspecoes = await _service.obterInspecoesPorUsuario(
        nextPage,
        state.statusId,
      );

      state = state.copyWith(
        inspecoes: [...state.inspecoes, ...novasInspecoes],
        currentPage: nextPage,
        hasMore: novasInspecoes.length >= 10,
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false);
      rethrow;
    }
  }

  Future<void> changeStatusFilter(int statusId) async {
    if (state.statusId == statusId) return;
    await loadInspecoes(statusId: statusId);
  }
}

final inspecaoServiceProvider = Provider<InspecaoService>((ref) {
  return InspecaoService();
});

final inspecaoProvider = NotifierProvider<InspecaoNotifier, InspecaoState>(() {
  return InspecaoNotifier();
});
