import 'package:inspecao_veicular_petroeng/models/status_inspecao.dart';

class ListaStatusInspecaoState {
  final List<StatusInspecao> statusInspecao;
  final bool isLoadingMore;

  ListaStatusInspecaoState({
    required this.statusInspecao,
    required this.isLoadingMore,
  });

  factory ListaStatusInspecaoState.initial() {
    return ListaStatusInspecaoState(isLoadingMore: false, statusInspecao: []);
  }

  ListaStatusInspecaoState copyWith({
    List<StatusInspecao>? statusInspecao,
    bool? isLoadingMore,
  }) {
    return ListaStatusInspecaoState(
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      statusInspecao: statusInspecao ?? this.statusInspecao,
    );
  }
}
