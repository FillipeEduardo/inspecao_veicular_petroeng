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

  static String? validacaoDouble(String? value) {
    if (value == null || value.isEmpty) {
      return "Preencha um número válido.";
    }

    if (double.tryParse(value) == null) {
      return "Número inválido.";
    }

    return null;
  }

  static String? validacaoAno(String? value) {
    if (value == null || value.isEmpty) {
      return "Esse campo é obrigatório.";
    } else if (DateTime.tryParse('$value-01-01') == null) {
      return "Preencha um ano válido.";
    }
    return null;
  }

  static String? validacaoTextoObrigatorio(String? value, num maxLenght) {
    if (value == null || value.isEmpty) {
      return "Esse campo é obrigatório.";
    } else if (value.length > maxLenght) {
      return "Esse campo ultrapassa o tamanho permitido de $maxLenght caracteres.";
    }
    return null;
  }
}
