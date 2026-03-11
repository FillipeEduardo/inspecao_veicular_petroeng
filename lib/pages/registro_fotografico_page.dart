import 'package:flutter/material.dart';

class RegistroFotograficoPage extends StatefulWidget {
  const RegistroFotograficoPage({super.key});

  @override
  State<RegistroFotograficoPage> createState() =>
      _RegistroFotograficoPageState();
}

class _RegistroFotograficoPageState extends State<RegistroFotograficoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("FOTO")),
    );
  }
}
