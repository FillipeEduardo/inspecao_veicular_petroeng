import 'package:inspecao_veicular_petroeng/models/veiculo.dart';

class ListaVeiculoState {
  final List<Veiculo> veiculos;
  final bool isLoadingMore;
  ListaVeiculoState({required this.veiculos, required this.isLoadingMore});

  factory ListaVeiculoState.initial() {
    return ListaVeiculoState(veiculos: [], isLoadingMore: false);
  }

  ListaVeiculoState copyWith({List<Veiculo>? veiculos, bool? isLoadingMore}) {
    return ListaVeiculoState(
      veiculos: veiculos ?? this.veiculos,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}
