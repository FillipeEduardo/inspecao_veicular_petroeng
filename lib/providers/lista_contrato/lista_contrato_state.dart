import 'package:inspecao_veicular_petroeng/models/contrato.dart';

class ListaContratoState {
  List<Contrato> contratos;
  bool loading;

  ListaContratoState({required this.contratos, required this.loading});

  factory ListaContratoState.initial() {
    return ListaContratoState(contratos: [], loading: false);
  }

  ListaContratoState copyWith({List<Contrato>? contratos, bool? loading}) {
    return ListaContratoState(
      contratos: contratos ?? this.contratos,
      loading: loading ?? this.loading,
    );
  }
}
