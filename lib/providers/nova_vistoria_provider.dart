import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/providers/nova_vistoria_state.dart';

class NovaVistoriaNotifier extends Notifier<NovaVistoriaState> {
  @override
  NovaVistoriaState build() {
    return NovaVistoriaState.initial();
  }

  void setState(NovaVistoriaState model) {
    state = model;
  }
}

final novaVistoriaProvider =
    NotifierProvider<NovaVistoriaNotifier, NovaVistoriaState>(() {
      return NovaVistoriaNotifier();
    });
