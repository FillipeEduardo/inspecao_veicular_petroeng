import 'package:flutter/material.dart';

class ListaInspecoesPage extends StatelessWidget {
  const ListaInspecoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          "Minhas Inspeções",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: .bold,
          ),
        ),
        shape: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(
              Icons.menu,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
