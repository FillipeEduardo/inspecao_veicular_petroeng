import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/components/dropdown_padrao.dart';
import 'package:inspecao_veicular_petroeng/providers/lista_veiculo/lista_veiculo_provider.dart';

class NovaVistoriaInicialPage extends ConsumerStatefulWidget {
  const NovaVistoriaInicialPage({super.key});

  @override
  ConsumerState<NovaVistoriaInicialPage> createState() =>
      _NovaVistoriaInicialPageState();
}

class _NovaVistoriaInicialPageState
    extends ConsumerState<NovaVistoriaInicialPage> {
  final _formKey = GlobalKey<FormState>();
  final _formState = <String, dynamic>{};

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(listaVeiculoProvider.notifier).load();
    });
    super.initState();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      print(_formState);
    }
  }

  @override
  Widget build(BuildContext context) {
    final listaVeiculosState = ref.watch(listaVeiculoProvider);
    final veiculos = listaVeiculosState.veiculos;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          "Nova Vistoria",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(
              Icons.menu,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownPadrao(
                    label: "Veículo para Inspeção",
                    opcoes: veiculos
                        .map(
                          (veiculo) => {
                            veiculo.id:
                                '${veiculo.modelo} - ${veiculo.placa.toUpperCase()}',
                          },
                        )
                        .toList(),
                    formState: _formState,
                    nome: "veiculoId",
                    validacao: (value) {
                      if (value == null) return "Selecione um veículo.";
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: _onSubmit,
                    child: Text("Continuar Inspeção"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
