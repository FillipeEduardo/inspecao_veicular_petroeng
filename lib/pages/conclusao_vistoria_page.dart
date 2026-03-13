import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/models/inspecao.dart';
import 'package:inspecao_veicular_petroeng/providers/nova_vistoria/nova_vistoria_provider.dart';

class ConclusaoVistoriaPage extends ConsumerStatefulWidget {
  const ConclusaoVistoriaPage({super.key});

  @override
  ConsumerState<ConclusaoVistoriaPage> createState() =>
      _ConclusaoVistoriaPageState();
}

class _ConclusaoVistoriaPageState extends ConsumerState<ConclusaoVistoriaPage> {
  @override
  Widget build(BuildContext context) {
    final inspecoes = ref.watch(novaVistoriaProvider).value!.inspecoes!;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          "Conclusão Vistoria",
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
      body: SafeArea(
        child: Center(
          child: inspecoes.isEmpty
              ? CircularProgressIndicator()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: inspecoes.length,
                  itemBuilder: (context, index) {
                    return _InspecaoCard(inspecao: inspecoes[index]);
                  },
                ),
        ),
      ),
    );
  }
}

class _InspecaoCard extends StatelessWidget {
  final Inspecao inspecao;
  const _InspecaoCard({required this.inspecao});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
