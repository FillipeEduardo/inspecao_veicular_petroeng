import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/components/input_padrao.dart';
import 'package:inspecao_veicular_petroeng/helpers/app_routes.dart';
import 'package:inspecao_veicular_petroeng/helpers/validators.dart';
import 'package:go_router/go_router.dart';
import 'package:inspecao_veicular_petroeng/models/success_api_result.dart';
import 'package:inspecao_veicular_petroeng/providers/auth/auth_notifier.dart';
import 'package:inspecao_veicular_petroeng/services/auth_service.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _formState = <String, String?>{};
  bool isLoading = false;

  Future<void> _onSubmit() async {
    setState(() => isLoading = true);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final apiResult = await AuthService().login(
        email: _formState["email"]!,
        senha: _formState["senha"]!,
      );
      if (apiResult.erros?.isNotEmpty == true && mounted) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Credenciais inválidas'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      final token = (apiResult as SuccessApiResult).dados;
      if (token != null) {
        await ref.read(authProvider.notifier).login(token);
        if (!mounted) return;
        context.go(AppRoutes.listaVistoria);
      }
    }
    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: .center,
        mainAxisAlignment: .center,
        spacing: 20,
        mainAxisSize: .max,
        children: [
          InputPadrao(
            nome: "email",
            formState: _formState,
            textInputAction: .next,
            label: "E-mail",
            keyboardType: .emailAddress,
            prefixIcon: Icon(Icons.mail),
            validacao: Validators.validacaoEmail,
          ),
          InputPadrao(
            nome: "senha",
            formState: _formState,
            textInputAction: .done,
            onSubmit: _onSubmit,
            keyboardType: .multiline,
            label: "Senha",
            ehSenha: true,
            prefixIcon: Icon(Icons.lock),
          ),
          Row(
            mainAxisAlignment: .end,
            children: [
              TextButton(
                onPressed: () => {},
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                  fixedSize: WidgetStatePropertyAll(Size(.infinity, 0)),
                  tapTargetSize: .shrinkWrap,
                  visualDensity: .compact,
                ),
                child: Text("Esqueci minha senha"),
              ),
            ],
          ),
          SizedBox(
            width: .infinity,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              decoration: BoxDecoration(
                color: isLoading
                    ? Colors.grey
                    : Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                onPressed: isLoading ? null : _onSubmit,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                  shadowColor: WidgetStatePropertyAll(Colors.transparent),
                  fixedSize: WidgetStatePropertyAll(Size.fromHeight(50)),
                ),
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Row(
                        mainAxisAlignment: .center,
                        spacing: 5,
                        children: [
                          Icon(Icons.login, color: Colors.white),
                          Text(
                            "Entrar",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: .bold,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
