class Contrato {
  final num id;
  final String nome;

  Contrato({required this.id, required this.nome});

  factory Contrato.fromJson(Map<String, dynamic> json) {
    return Contrato(id: json["id"], nome: json["nome"]);
  }
}
