import 'package:flutter/material.dart';

class InputPadrao extends StatefulWidget {
  final String label;
  final bool? ehSenha;
  final Widget? prefixIcon;

  const InputPadrao({
    super.key,
    required this.label,
    this.ehSenha,
    this.prefixIcon,
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
