import 'package:inspecao_veicular_petroeng/models/vistoria.dart';

class ListaVistoriaState {
  final List<Vistoria> vistorias;
  final int currentPage;
  final bool hasMore;
  final bool isLoadingMore;
  final bool isLoading;

  ListaVistoriaState({
    required this.vistorias,
    required this.currentPage,
    required this.hasMore,
    required this.isLoadingMore,
    required this.isLoading,
  });

  factory ListaVistoriaState.initial() {
    return ListaVistoriaState(
      vistorias: [],
      currentPage: 1,
      hasMore: true,
      isLoadingMore: false,
      isLoading: false,
    );
  }

  ListaVistoriaState copyWith({
    List<Vistoria>? vistorias,
    int? currentPage,
    bool? hasMore,
    bool? isLoadingMore,
    int? statusId,
    bool? isLoading,
  }) {
    return ListaVistoriaState(
      vistorias: vistorias ?? this.vistorias,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
