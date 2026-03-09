import 'package:inspecao_veicular_petroeng/models/vistoria.dart';

class VistoriaState {
  final List<Vistoria> vistorias;
  final int currentPage;
  final bool hasMore;
  final bool isLoadingMore;
  final int statusId;

  VistoriaState({
    required this.vistorias,
    required this.currentPage,
    required this.hasMore,
    required this.isLoadingMore,
    required this.statusId,
  });

  factory VistoriaState.initial({int statusId = 1}) {
    return VistoriaState(
      vistorias: [],
      currentPage: 1,
      hasMore: true,
      isLoadingMore: false,
      statusId: statusId,
    );
  }

  VistoriaState copyWith({
    List<Vistoria>? vistorias,
    int? currentPage,
    bool? hasMore,
    bool? isLoadingMore,
    int? statusId,
  }) {
    return VistoriaState(
      vistorias: vistorias ?? this.vistorias,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      statusId: statusId ?? this.statusId,
    );
  }
}
