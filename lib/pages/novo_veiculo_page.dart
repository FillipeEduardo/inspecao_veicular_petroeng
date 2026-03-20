import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inspecao_veicular_petroeng/components/input_padrao.dart';
import 'package:inspecao_veicular_petroeng/components/main_app_bar.dart';
import 'package:inspecao_veicular_petroeng/helpers/validators.dart';
import 'package:inspecao_veicular_petroeng/providers/lista_veiculo/lista_veiculo_provider.dart';
import 'package:inspecao_veicular_petroeng/services/veiculo_service.dart';

class NovoVeiculoPage extends ConsumerStatefulWidget {
  const NovoVeiculoPage({super.key});

  @override
  ConsumerState<NovoVeiculoPage> createState() => _NovoVeiculoPageState();
}

class _NovoVeiculoPageState extends ConsumerState<NovoVeiculoPage> {
  final _formKey = GlobalKey<FormState>();
  final _formState = <String, dynamic>{};

  Future<void> _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final veiculoId = await ref
          .read(veiculoServiceProvider)
          .criar(_formState);
      if (veiculoId != null) {
        await ref.read(listaVeiculoProvider.notifier).load();
        if (!mounted) return;
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final alturaSafe = mq.size.height - mq.padding.top - mq.padding.bottom;
    return Scaffold(
      appBar: MainAppBar(titulo: "Cadastrar Veiculo"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              child: Column(
                children: [
                  SizedBox(height: alturaSafe * 0.1),
                  Icon(
                    Icons.drive_eta,
                    color: Theme.of(context).colorScheme.primary,
                    size: 100,
                  ),
                  SizedBox(height: alturaSafe * 0.1),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: .center,
                      mainAxisAlignment: .center,
                      spacing: 30,
                      children: [
                        InputPadrao(
                          label: "Placa",
                          formState: _formState,
                          nome: "placa",
                          textInputAction: .next,
                          validacao: (value) =>
                              Validators.validacaoTextoObrigatorio(value, 7),
                        ),
                        InputPadrao(
                          label: "Ano",
                          formState: _formState,
                          nome: "ano",
                          textInputAction: .next,
                          validacao: Validators.validacaoAno,
                        ),
                        InputPadrao(
                          label: "Modelo",
                          formState: _formState,
                          nome: "modelo",
                          textInputAction: .done,
                          onSubmit: _onSubmit,
                          validacao: (value) =>
                              Validators.validacaoTextoObrigatorio(value, 50),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(10),
                              ),
                            ),
                            fixedSize: WidgetStatePropertyAll(
                              .new(.maxFinite, 50),
                            ),
                            backgroundColor: WidgetStatePropertyAll(
                              Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          onPressed: _onSubmit,
                          child: Text(
                            "Cadastrar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
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
