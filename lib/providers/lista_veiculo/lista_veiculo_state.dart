import 'package:inspecao_veicular_petroeng/models/veiculo.dart';

class ListaVeiculoState {
  final List<Veiculo> veiculos;
  ListaVeiculoState({required this.veiculos});

  factory ListaVeiculoState.initial() {
    return ListaVeiculoState(veiculos: []);
  }
}
