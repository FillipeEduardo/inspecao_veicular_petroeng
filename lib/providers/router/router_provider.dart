import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inspecao_veicular_petroeng/helpers/app_routes.dart';
import 'package:inspecao_veicular_petroeng/models/inspecao.dart';
import 'package:inspecao_veicular_petroeng/pages/inspecao_page.dart';
import 'package:inspecao_veicular_petroeng/pages/lista_vistoria_page.dart';
import 'package:inspecao_veicular_petroeng/pages/login_page.dart';
import 'package:inspecao_veicular_petroeng/pages/nova_vistoria_inicial_page.dart';
import 'package:inspecao_veicular_petroeng/providers/auth/auth_notifier.dart';
import 'package:inspecao_veicular_petroeng/providers/auth/auth_state.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: AppRoutes.listaVistoria,
    redirect: (context, state) {
      final isAuthenticated =
          authState.value?.status == AuthStatus.authenticated;

      if (!isAuthenticated && state.matchedLocation != AppRoutes.login) {
        return AppRoutes.login;
      }
      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.login, builder: (_, _) => const LoginPage()),
      GoRoute(
        path: AppRoutes.listaVistoria,
        builder: (_, _) => const ListaVistoriaPage(),
      ),
      GoRoute(
        path: AppRoutes.novaVistoriaInicial,
        builder: (_, _) => const NovaVistoriaInicialPage(),
      ),
      GoRoute(
        path: AppRoutes.inspecao,
        builder: (_, state) {
          final inspecao = state.extra as Inspecao;
          return InspecaoPage(inspecao: inspecao);
        },
      ),
    ],
  );
});
