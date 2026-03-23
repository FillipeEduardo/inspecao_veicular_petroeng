import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inspecao_veicular_petroeng/components/botao_padrao.dart';
import 'package:inspecao_veicular_petroeng/components/input_padrao.dart';
import 'package:inspecao_veicular_petroeng/components/main_app_bar.dart';
import 'package:inspecao_veicular_petroeng/helpers/validators.dart';
import 'package:inspecao_veicular_petroeng/services/contrato_service.dart';

class CadastrarContratoPage extends ConsumerStatefulWidget {
  const CadastrarContratoPage({super.key});

  @override
  ConsumerState<CadastrarContratoPage> createState() =>
      _CadastrarContratoPageState();
}

class _CadastrarContratoPageState extends ConsumerState<CadastrarContratoPage> {
  final _formKey = GlobalKey<FormState>();
  final _formState = <String, dynamic>{};

  Future<void> _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final apiResult = await ref
          .read(contratoServiceProvider)
          .criar(_formState);
      if (apiResult.dados != null && mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final alturaSafe = mq.size.height - mq.padding.top - mq.padding.bottom;
    return Scaffold(
      appBar: MainAppBar(titulo: "Cadastrar Contrato"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              spacing: alturaSafe * 0.2,
              crossAxisAlignment: .center,
              children: [
                SizedBox(height: alturaSafe * 0),
                Icon(
                  Icons.edit_document,
                  color: Theme.of(context).colorScheme.primary,
                  size: 60,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    spacing: 30,
                    children: [
                      InputPadrao(
                        label: "Nome",
                        formState: _formState,
                        nome: "nome",
                        onSubmit: _onSubmit,
                        textInputAction: .done,
                        validacao: (value) =>
                            Validators.validacaoTextoObrigatorio(value, 100),
                      ),
                      BotaoPadrao(texto: "Enviar", onPressed: _onSubmit),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
