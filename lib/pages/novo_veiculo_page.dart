import 'package:flutter/material.dart';
import 'package:inspecao_veicular_petroeng/components/input_padrao.dart';
import 'package:inspecao_veicular_petroeng/components/main_app_bar.dart';
import 'package:inspecao_veicular_petroeng/components/main_drawer.dart';
import 'package:inspecao_veicular_petroeng/helpers/validators.dart';

class NovoVeiculoPage extends StatefulWidget {
  const NovoVeiculoPage({super.key});

  @override
  State<NovoVeiculoPage> createState() => _NovoVeiculoPageState();
}

class _NovoVeiculoPageState extends State<NovoVeiculoPage> {
  final _formKey = GlobalKey<FormState>();
  final _formState = <String, String?>{};

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final alturaSafe = mq.size.height - mq.padding.top - mq.padding.bottom;
    return Scaffold(
      drawer: MainDrawer(),
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
