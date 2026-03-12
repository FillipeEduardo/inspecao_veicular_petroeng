import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inspecao_veicular_petroeng/components/dropdown_padrao.dart';
import 'package:inspecao_veicular_petroeng/components/input_padrao.dart';
import 'package:inspecao_veicular_petroeng/helpers/app_routes.dart';
import 'package:inspecao_veicular_petroeng/models/inspecao.dart';
import 'package:inspecao_veicular_petroeng/providers/lista_status_inspecao/lista_status_inspecao_provider.dart';
import 'package:inspecao_veicular_petroeng/providers/lista_status_inspecao/lista_status_inspecao_state.dart';
import 'package:inspecao_veicular_petroeng/providers/nova_vistoria/nova_vistoria_provider.dart';

class InspecaoPage extends ConsumerStatefulWidget {
  final Inspecao inspecao;
  const InspecaoPage({super.key, required this.inspecao});

  @override
  ConsumerState<InspecaoPage> createState() => _InspecaoPageState();
}

class _InspecaoPageState extends ConsumerState<InspecaoPage> {
  final _formKey = GlobalKey<FormState>();
  final _formState = <String, dynamic>{};

  void _onSubmit(ListaStatusInspecaoState listaStatusInspecaoState) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ref.read(novaVistoriaProvider.notifier).atualizar((novaVistoria) {
        final inspecoes = novaVistoria.inspecoes!;
        inspecoes.removeWhere(
          (inspecao) => inspecao.item.id == widget.inspecao.item.id,
        );
        final novaInspecao = Inspecao(
          item: widget.inspecao.item,
          status: listaStatusInspecaoState.statusInspecao.firstWhere(
            (statusInspecao) =>
                statusInspecao.id == _formState["statusInspecaoId"],
          ),
          observacao: _formState["observacao"],
        );
        inspecoes.add(novaInspecao);
        return novaVistoria.copyWith(inspecoes: inspecoes);
      });
      final novaVistoria = ref.read(novaVistoriaProvider).value!;
      if (novaVistoria.inspecoes!.any((inspecao) => inspecao.status.id == 0)) {
        final inspecaoPendente = novaVistoria.inspecoes!.firstWhere(
          (inspecao) => inspecao.status.id == 0,
        );
        context.push(AppRoutes.inspecao, extra: inspecaoPendente);
      } else {
        context.push(AppRoutes.registroFotografico);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final listaStatusInspecaoState = ref.watch(listaStatusInspecaoProvider);
    final mq = MediaQuery.of(context);
    final alturaSafe = mq.size.height - mq.padding.top - mq.padding.bottom;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          "Inspeção",
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
      body: SingleChildScrollView(
        child: Container(
          height: alturaSafe * 0.9,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Text(
                widget.inspecao.item.nome,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: .bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: alturaSafe * 0.15),
              Form(
                key: _formKey,
                child: Column(
                  spacing: 30,
                  children: [
                    DropdownPadrao(
                      label: "Status do Item",
                      opcoes: listaStatusInspecaoState.statusInspecao
                          .map((x) => {x.id: x.nome})
                          .toList(),
                      formState: _formState,
                      nome: "statusInspecaoId",
                      validacao: (value) {
                        if (value == null) return "Selecione um status.";
                        return null;
                      },
                    ),
                    InputPadrao(
                      label: "Observação",
                      formState: _formState,
                      nome: "observacao",
                      maxLines: 5,
                    ),
                    Container(
                      width: .infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                        onPressed: () => _onSubmit(listaStatusInspecaoState),
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.transparent,
                          ),
                          shadowColor: WidgetStatePropertyAll(
                            Colors.transparent,
                          ),
                          fixedSize: WidgetStatePropertyAll(
                            Size.fromHeight(50),
                          ),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
