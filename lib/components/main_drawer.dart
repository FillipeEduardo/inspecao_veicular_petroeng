import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inspecao_veicular_petroeng/helpers/app_routes.dart';
import 'package:inspecao_veicular_petroeng/providers/auth/auth_notifier.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mq = MediaQuery.of(context);
    final alturaSafe = mq.size.height - mq.padding.top - mq.padding.bottom;
    return Drawer(
      child: Column(
        children: [
          Container(
            height: alturaSafe * 0.15,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            alignment: .bottomCenter,
            padding: EdgeInsets.all(5),
            child: Text(
              'Petroeng - Inspeção veicular',
              style: TextStyle(color: Colors.white, fontWeight: .bold),
            ),
          ),
          SizedBox(height: alturaSafe * 0.05),
          ListTile(
            onTap: () => context.push(AppRoutes.novaVistoriaInicial),
            leading: Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              "Realizar Vistoria",
              style: TextStyle(fontWeight: .bold),
            ),
          ),
          ListTile(
            onTap: () => context.push(AppRoutes.novoVeiculo),
            leading: Icon(
              Icons.drive_eta,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              "Cadastrar Veiculo",
              style: TextStyle(fontWeight: .bold),
            ),
          ),
          SizedBox(height: alturaSafe * 0.65),
          ElevatedButton(
            style: ButtonStyle(
              shadowColor: WidgetStatePropertyAll(Colors.transparent),
              backgroundColor: WidgetStatePropertyAll(Colors.transparent),
            ),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              context.go(AppRoutes.login);
            },
            child: Row(
              spacing: 10,
              crossAxisAlignment: .center,
              mainAxisAlignment: .center,
              children: [
                Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Text("Sair", style: TextStyle(fontWeight: .bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
