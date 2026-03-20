class Apiresult {
  final int httpStatusCode;
  final List<String>? erros;

  Apiresult({required this.httpStatusCode, this.erros});

  factory Apiresult.fromJson(Map<String, dynamic> json) {
    return Apiresult(
      httpStatusCode: json["httpStatusCode"],
      erros: json["erros"] == null
          ? null
          : (json["erros"] as List).cast<String>(),
    );
  }
}
