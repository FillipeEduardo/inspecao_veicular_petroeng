import 'package:flutter/material.dart';
import 'package:inspecao_veicular_petroeng/components/input_padrao.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .center,
        mainAxisSize: .max,
        children: [
          InputPadrao(label: "E-mail", prefixIcon: Icon(Icons.mail)),
          InputPadrao(
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
            child: ElevatedButton(
              onPressed: () => {},
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.primary,
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                fixedSize: WidgetStatePropertyAll(Size.fromHeight(50)),
              ),
              child: Row(
                mainAxisAlignment: .center,
                spacing: 5,
                children: [
                  Icon(Icons.login, color: Colors.white),
                  Text(
                    "Entrar",
                    style: TextStyle(color: Colors.white, fontWeight: .bold),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Divider(color: Colors.grey.shade400, thickness: 1),
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
                child: Divider(color: Colors.grey.shade400, thickness: 1),
              ),
            ],
          ),
          SizedBox(
            width: .infinity,
            child: ElevatedButton(
              onPressed: () => {},
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.white),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                fixedSize: WidgetStatePropertyAll(Size.fromHeight(50)),
              ),
              child: Row(
                mainAxisAlignment: .center,
                spacing: 5,
                children: [
                  Icon(
                    Icons.person_add_alt_1,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Text(
                    "Criar nova conta",
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
    );
  }
}
