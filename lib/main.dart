import 'package:flutter/material.dart';
import 'package:inspecao_veicular_petroeng/helpers/app_routes.dart';
import 'package:inspecao_veicular_petroeng/pages/lista_vistoria_page.dart';
import 'package:inspecao_veicular_petroeng/pages/login_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/pages/nova_vistoria_inicial_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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
          secondary: Color(0xFFF97316),
        ),
      ),
      home: LoginPage(),
      routes: {
        AppRoutes.login: (ctx) => const LoginPage(),
        AppRoutes.listaVistoria: (ctx) => const ListaVistoriaPage(),
        AppRoutes.novaVistoriaInicial: (ctx) => const NovaVistoriaInicialPage(),
      },
    );
  }
}
