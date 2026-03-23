class ListResult<T> {
  final List<T> registros;
  final num totalDePaginas;
  final num paginaAtual;
  final num totalDeRegistros;

  ListResult({
    required this.registros,
    required this.totalDePaginas,
    required this.paginaAtual,
    required this.totalDeRegistros,
  });

  factory ListResult.fromJson(
    Map<String, dynamic> json,
    List<T> Function(Object?) fromJsonListT,
  ) {
    return ListResult(
      registros: fromJsonListT(json["registros"]),
      totalDePaginas: json["totalDePaginas"],
      paginaAtual: json["paginaAtual"],
      totalDeRegistros: json["totalDeRegistros"],
    );
  }
}
