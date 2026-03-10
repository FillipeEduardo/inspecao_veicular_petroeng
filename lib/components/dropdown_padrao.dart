import 'package:flutter/material.dart';

class DropdownPadrao extends StatefulWidget {
  final String label;
  final List<Map<int, String>> opcoes;
  final FormFieldValidator<int>? validacao;
  final Map<String, dynamic> formState;
  final String nome;
  final Widget? prefixIcon;
  final String? hintText;
  final bool habilitado;
  final void Function(int?)? onChanged;
  final String textoBusca;
  final String textoSemResultados;

  const DropdownPadrao({
    super.key,
    required this.label,
    required this.opcoes,
    this.validacao,
    required this.formState,
    required this.nome,
    this.prefixIcon,
    this.hintText,
    this.habilitado = true,
    this.onChanged,
    this.textoBusca = 'Pesquisar...',
    this.textoSemResultados = 'Nenhum resultado encontrado',
  });

  @override
  State<DropdownPadrao> createState() => _DropdownPadraoState();
}

class _DropdownPadraoState extends State<DropdownPadrao> {
  int? valorSelecionado;

  List<MapEntry<int, String>> get _itens {
    return widget.opcoes.expand((mapa) => mapa.entries).toList();
  }

  String? get _textoSelecionado {
    for (final item in _itens) {
      if (item.key == valorSelecionado) {
        return item.value;
      }
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    valorSelecionado = widget.formState[widget.nome];
  }

  @override
  void didUpdateWidget(covariant DropdownPadrao oldWidget) {
    super.didUpdateWidget(oldWidget);

    final valorAtualizado = widget.formState[widget.nome];
    if (valorAtualizado != valorSelecionado) {
      setState(() {
        valorSelecionado = valorAtualizado;
      });
    }
  }

  Future<int?> _abrirSelecao(BuildContext context) async {
    final buscaController = TextEditingController();
    String termoBusca = '';

    final valor = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      builder: (modalContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(modalContext).viewInsets.bottom + 16,
          ),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              final opcoesFiltradas = _itens
                  .where(
                    (item) => item.value.toLowerCase().contains(
                      termoBusca.toLowerCase(),
                    ),
                  )
                  .toList();

              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  children: [
                    TextField(
                      controller: buscaController,
                      decoration: InputDecoration(
                        hintText: widget.textoBusca,
                        prefixIcon: const Icon(Icons.search),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      onChanged: (valor) {
                        setModalState(() {
                          termoBusca = valor;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: opcoesFiltradas.isEmpty
                          ? Center(child: Text(widget.textoSemResultados))
                          : ListView.builder(
                              itemCount: opcoesFiltradas.length,
                              itemBuilder: (context, index) {
                                final opcao = opcoesFiltradas[index];
                                final selecionado =
                                    opcao.key == valorSelecionado;

                                return ListTile(
                                  title: Text(opcao.value),
                                  trailing: selecionado
                                      ? const Icon(Icons.check)
                                      : null,
                                  onTap: () {
                                    Navigator.of(modalContext).pop(opcao.key);
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );

    buscaController.dispose();
    return valor;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<int>(
      initialValue: valorSelecionado,
      validator: widget.validacao,
      onSaved: (value) => widget.formState[widget.nome] = value,
      builder: (field) {
        return InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: widget.habilitado
              ? () async {
                  final selecionado = await _abrirSelecao(context);

                  if (selecionado == null) {
                    return;
                  }

                  setState(() {
                    valorSelecionado = selecionado;
                  });

                  widget.formState[widget.nome] = selecionado;
                  field.didChange(selecionado);
                  widget.onChanged?.call(selecionado);
                }
              : null,
          child: InputDecorator(
            isEmpty: valorSelecionado == null,
            decoration: InputDecoration(
              labelText: widget.label,
              hintText: widget.hintText,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              prefixIcon: widget.prefixIcon,
              enabled: widget.habilitado,
              errorText: field.errorText,
              suffixIcon: const Icon(Icons.arrow_drop_down),
            ),
            child: Text(_textoSelecionado ?? ''),
          ),
        );
      },
    );
  }
}
