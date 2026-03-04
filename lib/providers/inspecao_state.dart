import 'package:inspecao_veicular_petroeng/models/inspecao.dart';

class InspecaoState {
  final List<Inspecao> inspecoes;
  final int currentPage;
  final bool hasMore;
  final bool isLoadingMore;
  final int statusId;

  InspecaoState({
    required this.inspecoes,
    required this.currentPage,
    required this.hasMore,
    required this.isLoadingMore,
    required this.statusId,
  });

  factory InspecaoState.initial({int statusId = 1}) {
    return InspecaoState(
      inspecoes: [],
      currentPage: 1,
      hasMore: true,
      isLoadingMore: false,
      statusId: statusId,
    );
  }

  InspecaoState copyWith({
    List<Inspecao>? inspecoes,
    int? currentPage,
    bool? hasMore,
    bool? isLoadingMore,
    int? statusId,
  }) {
    return InspecaoState(
      inspecoes: inspecoes ?? this.inspecoes,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      statusId: statusId ?? this.statusId,
    );
  }
}
