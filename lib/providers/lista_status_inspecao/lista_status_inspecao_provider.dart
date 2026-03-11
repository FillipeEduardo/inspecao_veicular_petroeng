import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/providers/lista_status_inspecao/lista_status_inspecao_state.dart';
import 'package:inspecao_veicular_petroeng/providers/services/status_inspecao_service_provider.dart';
import 'package:inspecao_veicular_petroeng/services/status_inspecao_service.dart';

class ListaStatusInspecaoNotifier extends Notifier<ListaStatusInspecaoState> {
  StatusInspecaoService get _service => ref.read(statusInspecaoServiceProvider);
  @override
  ListaStatusInspecaoState build() {
    return ListaStatusInspecaoState.initial();
  }

  Future<void> load() async {
    if (state.isLoadingMore) return;
    state = state.copyWith(isLoadingMore: true);
    final statusInspecao = await _service.todos();
    state = state.copyWith(
      statusInspecao: statusInspecao,
      isLoadingMore: false,
    );
  }
}

final listaStatusInspecaoProvider =
    NotifierProvider<ListaStatusInspecaoNotifier, ListaStatusInspecaoState>(() {
      return ListaStatusInspecaoNotifier();
    });
