import 'package:flutter/material.dart';
import 'package:inspecao_veicular_petroeng/helpers/app_routes.dart';
import 'package:inspecao_veicular_petroeng/pages/lista_inspecoes_page.dart';
import 'package:inspecao_veicular_petroeng/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inspeção Veicular PetroEng',
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: Color(0xFF1E3A8A),
          primary: Color(0xFF1E3A8A),
        ),
      ),
      home: LoginPage(),
      routes: {
        AppRoutes.login: (ctx) => const LoginPage(),
        AppRoutes.listaInspecoes: (ctx) => const ListaInspecoesPage(),
      },
    );
  }
}
