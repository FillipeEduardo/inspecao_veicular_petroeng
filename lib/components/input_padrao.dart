import 'package:flutter/material.dart';

class InputPadrao extends StatefulWidget {
  final String label;
  final bool? ehSenha;
  final Widget? prefixIcon;
  final FormFieldValidator<String>? validacao;
  final Map<String, dynamic> formState;
  final String nome;
  final TextInputAction? textInputAction;
  final void Function()? onSubmit;
  final TextInputType? keyboardType;

  const InputPadrao({
    super.key,
    required this.label,
    this.ehSenha,
    this.prefixIcon,
    this.validacao,
    required this.formState,
    required this.nome,
    this.textInputAction,
    this.onSubmit,
    this.keyboardType,
  });

  @override
  State<InputPadrao> createState() => _InputPadraoState();
}

class _InputPadraoState extends State<InputPadrao> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.ehSenha ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validacao,
      initialValue: widget.formState[widget.nome],
      textInputAction: widget.textInputAction,
      onSaved: (value) => widget.formState[widget.nome] = value,
      keyboardType: widget.keyboardType,
      onFieldSubmitted: widget.onSubmit != null
          ? (_) => widget.onSubmit!()
          : null,
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: widget.ehSenha == true
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              )
            : null,
        prefixIcon: widget.prefixIcon,
      ),
      obscureText: obscureText,
    );
  }
}
