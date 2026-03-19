import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inspecao_veicular_petroeng/helpers/app_routes.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 100,
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
          SizedBox(height: 10),
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
            onTap: null,
            leading: Icon(
              Icons.drive_eta,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              "Cadastrar Veiculo",
              style: TextStyle(fontWeight: .bold),
            ),
          ),
        ],
      ),
    );
  }
}
