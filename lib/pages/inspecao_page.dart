import 'package:flutter/material.dart';
import 'package:inspecao_veicular_petroeng/components/dropdown_padrao.dart';
import 'package:inspecao_veicular_petroeng/models/inspecao.dart';

class InspecaoPage extends StatefulWidget {
  final Inspecao inspecao;
  const InspecaoPage({super.key, required this.inspecao});

  @override
  State<InspecaoPage> createState() => _InspecaoPageState();
}

class _InspecaoPageState extends State<InspecaoPage> {
  final _formKey = GlobalKey<FormState>();
  final _formState = <String, dynamic>{};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          widget.inspecao.item.nome,
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownPadrao(
                  label: "Status do Item",
                  opcoes: [],
                  formState: _formState,
                  nome: "statusInspecao",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
