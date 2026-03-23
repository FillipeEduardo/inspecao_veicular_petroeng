import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inspecao_veicular_petroeng/components/inspecao_card.dart';
import 'package:inspecao_veicular_petroeng/helpers/app_routes.dart';
import 'package:inspecao_veicular_petroeng/providers/nova_vistoria/nova_vistoria_provider.dart';
import 'package:inspecao_veicular_petroeng/services/vistoria_service.dart';

class ConclusaoVistoriaPage extends ConsumerStatefulWidget {
  const ConclusaoVistoriaPage({super.key});

  @override
  ConsumerState<ConclusaoVistoriaPage> createState() =>
      _ConclusaoVistoriaPageState();
}

class _ConclusaoVistoriaPageState extends ConsumerState<ConclusaoVistoriaPage> {
  bool isLoading = false;
  Future<void> _salvarNovaVistoria() async {
    setState(() {
      isLoading = true;
    });
    final novaVistoria = ref.read(novaVistoriaProvider).value!;
    final apiResult = await ref
        .read(vistoriaServiceProvider)
        .criar(novaVistoria);
    if (apiResult.erros == null && apiResult.dados != null) {
      ref.read(novaVistoriaProvider.notifier).atualizar((state) {
        return state.copyWith(id: apiResult.dados!);
      });
      novaVistoria.fotos?.forEach((foto) async {
        await ref
            .read(vistoriaServiceProvider)
            .criarFoto(foto.file!.path, apiResult.dados!, foto.evidencia.id);
      });
      setState(() {
        isLoading = false;
      });
      if (!mounted) return;
      context.go(AppRoutes.listaVistoria);
    }
  }

  @override
  Widget build(BuildContext context) {
    final inspecoes = ref.watch(novaVistoriaProvider).value!.inspecoes!;
    inspecoes.sort((a, b) => a.item.nome.compareTo(b.item.nome));

    if (isLoading) {
      return Scaffold(
        body: SafeArea(child: Center(child: CircularProgressIndicator())),
      );
    }
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
            child: InkWell(
              onTap: _salvarNovaVistoria,
              child: Icon(
                Icons.save,
                color: Theme.of(context).colorScheme.primary,
              ),
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
                    return InspecaoCard(inspecao: inspecoes[index]);
                  },
                ),
        ),
      ),
    );
  }
}
