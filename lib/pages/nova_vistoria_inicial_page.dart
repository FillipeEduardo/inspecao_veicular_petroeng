import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(listaVeiculoProvider.notifier).load();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final veiculos = ref.watch(listaVeiculoProvider);
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
          child: Form(child: Column(children: [
            
          ],
        )),
        ),
      ),
    );
  }
}
