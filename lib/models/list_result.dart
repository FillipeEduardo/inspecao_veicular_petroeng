class ListResult<T> {
  final String mensagem;
  final Dados<T> dados;
  final num httpStatusCode;

  ListResult({
    required this.mensagem,
    required this.dados,
    required this.httpStatusCode,
  });

  factory ListResult.fromJson(
    Map<String, dynamic> json,
    List<T> Function(Object?) fromJsonT,
  ) {
    final dadosJson = json['dados'] as Map<String, dynamic>;

    return ListResult<T>(
      httpStatusCode: json['httpStatusCode'] as int,
      mensagem: json['mensagem'] as String,
      dados: Dados(
        registros: fromJsonT(dadosJson['registros']),
        totalDePaginas: dadosJson['totalDePaginas'] as num,
        paginaAtual: dadosJson['paginaAtual'] as num,
        totalDeRegistros: dadosJson['totalDeRegistros'] as num,
      ),
    );
  }
}

class Dados<T> {
  final List<T> registros;
  final num totalDePaginas;
  final num paginaAtual;
  final num totalDeRegistros;

  Dados({
    required this.registros,
    required this.totalDePaginas,
    required this.paginaAtual,
    required this.totalDeRegistros,
  });
}
