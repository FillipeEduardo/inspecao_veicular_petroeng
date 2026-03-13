import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inspecao_veicular_petroeng/components/dropdown_padrao.dart';
import 'package:inspecao_veicular_petroeng/components/input_padrao.dart';
import 'package:inspecao_veicular_petroeng/helpers/app_routes.dart';
import 'package:inspecao_veicular_petroeng/helpers/validators.dart';
import 'package:inspecao_veicular_petroeng/models/inspecao.dart';
import 'package:inspecao_veicular_petroeng/models/veiculo.dart';
import 'package:inspecao_veicular_petroeng/providers/lista_status_inspecao/lista_status_inspecao_provider.dart';
import 'package:inspecao_veicular_petroeng/providers/lista_veiculo/lista_veiculo_provider.dart';
import 'package:inspecao_veicular_petroeng/providers/nova_vistoria/nova_vistoria_provider.dart';
import 'package:intl/intl.dart';

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
      ref.read(listaStatusInspecaoProvider.notifier).load();
    });
    super.initState();
  }

  void _onSubmit(Veiculo? veiculoSelecionado, Inspecao? proximaInspecao) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ref
          .read(novaVistoriaProvider.notifier)
          .atualizar(
            (novaVistoria) => novaVistoria.copyWith(
              quilometragemVeiculo: double.parse(
                _formState["quilometragemVeiculo"],
              ),
              veiculo: veiculoSelecionado,
            ),
          );
      context.push(AppRoutes.inspecao, extra: proximaInspecao);
    }
  }

  @override
  Widget build(BuildContext context) {
    final listaVeiculosState = ref.watch(listaVeiculoProvider);
    final veiculos = listaVeiculosState.veiculos;
    final veiculoSelecionado = _formState["veiculoId"] != null
        ? veiculos.firstWhere(
            (veiculo) => _formState["veiculoId"] == veiculo.id,
          )
        : null;
    final novaInspecao = ref.watch(novaVistoriaProvider);
    final proximaInspecao = novaInspecao.value?.inspecoes?.first;

    if (listaVeiculosState.isLoadingMore) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

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
                spacing: 30,
                children: [
                  Column(
                    spacing: 10,
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
                        onChanged: (veiculoId) => setState(() {
                          _formState["veiculoId"] = veiculoId;
                        }),
                        validacao: (value) {
                          if (value == null) return "Selecione um veículo.";
                          return null;
                        },
                      ),
                      Row(
                        spacing: 5,
                        children: [
                          Icon(
                            Icons.info,
                            color: Theme.of(context).colorScheme.primary,
                            size: 15,
                          ),
                          Text(
                            "Selecione o veiculo que será inspecionado",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    spacing: 10,
                    children: [
                      InputPadrao(
                        label: "Quilometragem Atual (KM)",
                        formState: _formState,
                        nome: "quilometragemVeiculo",
                        keyboardType: .number,
                        validacao: Validators.validacaoDouble,
                        onSubmit: () =>
                            _onSubmit(veiculoSelecionado, proximaInspecao),
                        textInputAction: .done,
                      ),
                      Row(
                        spacing: 5,
                        children: [
                          Icon(
                            Icons.info,
                            color: Theme.of(context).colorScheme.primary,
                            size: 15,
                          ),
                          Text(
                            "Informe a quilometragem exata do odômetro",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (veiculoSelecionado != null)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.black.withValues(alpha: 0.1),
                          width: 1,
                        ),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        spacing: 15,
                        children: [
                          Row(
                            spacing: 10,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.shade50,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Icon(
                                  Icons.car_crash_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: .start,
                                mainAxisAlignment: .center,
                                children: [
                                  Text(
                                    '${veiculoSelecionado.modelo} - ${veiculoSelecionado.ano}',
                                    style: TextStyle(fontWeight: .bold),
                                  ),
                                  Text(
                                    veiculoSelecionado.placa.toUpperCase(),
                                    style: TextStyle(fontWeight: .w300),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            spacing: 40,
                            children: [
                              Column(
                                crossAxisAlignment: .start,
                                children: [
                                  Text(
                                    "Ultima inspeção:",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    veiculoSelecionado.ultimaVistoria?.data !=
                                            null
                                        ? DateFormat.yMEd().format(
                                            veiculoSelecionado
                                                .ultimaVistoria!
                                                .data,
                                          )
                                        : "N/A",
                                    style: TextStyle(
                                      fontWeight: .bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: .start,
                                children: [
                                  Text(
                                    "KM anterior:",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    veiculoSelecionado
                                                .ultimaVistoria
                                                ?.quilometragemVeiculo !=
                                            null
                                        ? '${veiculoSelecionado.ultimaVistoria!.quilometragemVeiculo} KM'
                                        : "N/A",
                                    style: TextStyle(
                                      fontWeight: .bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  Container(
                    width: .infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: () =>
                          _onSubmit(veiculoSelecionado, proximaInspecao),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.transparent,
                        ),
                        shadowColor: WidgetStatePropertyAll(Colors.transparent),
                        fixedSize: WidgetStatePropertyAll(Size.fromHeight(50)),
                      ),
                      child: Row(
                        crossAxisAlignment: .center,
                        mainAxisAlignment: .center,
                        spacing: 5,
                        children: [
                          Text(
                            "Continuar Inspeção",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: .bold,
                            ),
                          ),
                          Icon(Icons.arrow_forward, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey.shade400,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "ou",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey.shade400,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: .infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () =>
                          _onSubmit(veiculoSelecionado, proximaInspecao),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.transparent,
                        ),
                        shadowColor: WidgetStatePropertyAll(Colors.transparent),
                        fixedSize: WidgetStatePropertyAll(Size.fromHeight(50)),
                      ),
                      child: Row(
                        crossAxisAlignment: .center,
                        mainAxisAlignment: .center,
                        spacing: 5,
                        children: [
                          Icon(
                            Icons.add,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          Text(
                            "Cadastrar Novo Veículo",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: .bold,
                            ),
                          ),
                        ],
                      ),
                    ),
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
