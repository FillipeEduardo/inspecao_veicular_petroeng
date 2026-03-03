class Validators {
  static String? validacaoEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Preencha um e-mail válido.";
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return "E-mail inválido.";
    }

    return null;
  }
}
