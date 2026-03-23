class Apiresult<T> {
  final int httpStatusCode;
  final List<String>? erros;
  final String mensagem;
  final T? dados;

  Apiresult({
    required this.httpStatusCode,
    required this.mensagem,
    this.erros,
    this.dados,
  });

  factory Apiresult.fromJson(
    Map<String, dynamic> json, {
    T Function(Object?)? fromJsonT,
  }) {
    return Apiresult(
      httpStatusCode: json["httpStatusCode"],
      erros: json["erros"] == null
          ? null
          : (json["erros"] as List).cast<String>(),
      mensagem: json['mensagem'] as String,
      dados: fromJsonT == null ? null : fromJsonT(json['dados']),
    );
  }
}
