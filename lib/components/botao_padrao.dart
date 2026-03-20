import 'package:flutter/material.dart';

class BotaoPadrao extends StatelessWidget {
  final void Function()? onPressed;
  final String texto;
  const BotaoPadrao({super.key, this.onPressed, required this.texto});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
        ),
        fixedSize: WidgetStatePropertyAll(.new(.maxFinite, 50)),
        backgroundColor: WidgetStatePropertyAll(
          Theme.of(context).colorScheme.primary,
        ),
      ),
      onPressed: onPressed,
      child: Text(texto, style: TextStyle(color: Colors.white)),
    );
  }
}
