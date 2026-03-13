import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inspecao_veicular_petroeng/helpers/app_routes.dart';
import 'package:inspecao_veicular_petroeng/models/foto.dart';
import 'package:inspecao_veicular_petroeng/models/inspecao.dart';
import 'package:inspecao_veicular_petroeng/pages/conclusao_vistoria_page.dart';
import 'package:inspecao_veicular_petroeng/pages/inspecao_page.dart';
import 'package:inspecao_veicular_petroeng/pages/lista_vistoria_page.dart';
import 'package:inspecao_veicular_petroeng/pages/login_page.dart';
import 'package:inspecao_veicular_petroeng/pages/nova_vistoria_inicial_page.dart';
import 'package:inspecao_veicular_petroeng/pages/registro_fotografico_page.dart';
import 'package:inspecao_veicular_petroeng/providers/auth/auth_notifier.dart';
import 'package:inspecao_veicular_petroeng/providers/auth/auth_state.dart';

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen(authProvider, (_, _) => notifyListeners());
  }

  bool get isAuthenticated {
    final authState = _ref.read(authProvider);
    return authState.value?.status == AuthStatus.authenticated;
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = RouterNotifier(ref);

  return GoRouter(
    initialLocation: AppRoutes.listaVistoria,
    refreshListenable: notifier,
    redirect: (context, state) {
      final authAsync = ref.read(authProvider);

      if (authAsync.isLoading) return null;

      final isAuthenticated =
          authAsync.value?.status == AuthStatus.authenticated;
      final isOnLogin = state.matchedLocation == AppRoutes.login;

      if (!isAuthenticated && !isOnLogin) return AppRoutes.login;
      if (isAuthenticated && isOnLogin) return AppRoutes.listaVistoria;

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
      GoRoute(
        path: AppRoutes.registroFotografico,
        builder: (_, state) {
          final foto = state.extra as Foto;
          return RegistroFotograficoPage(foto: foto);
        },
      ),
      GoRoute(
        path: AppRoutes.conclusaoVistoria,
        builder: (_, _) => const ConclusaoVistoriaPage(),
      ),
    ],
  );
});
