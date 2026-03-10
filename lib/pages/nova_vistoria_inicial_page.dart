import 'package:flutter/material.dart';

class NovaVistoriaInicialPage extends StatefulWidget {
  const NovaVistoriaInicialPage({super.key});

  @override
  State<NovaVistoriaInicialPage> createState() =>
      _NovaVistoriaInicialPageState();
}

class _NovaVistoriaInicialPageState extends State<NovaVistoriaInicialPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          "Nova Vistoria",
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
            child: Icon(
              Icons.menu,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(child: Column(children: [
            
          ],
        )),
        ),
      ),
    );
  }
}
