import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;
  const MainAppBar({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      title: Text(
        titulo,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
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
          child: Icon(Icons.menu, color: Theme.of(context).colorScheme.primary),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}
