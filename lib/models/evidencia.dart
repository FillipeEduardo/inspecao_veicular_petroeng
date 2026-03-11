class Evidencia {
  final int id;
  final String nome;

  Evidencia({required this.id, required this.nome});

  factory Evidencia.fromJson(Map<String, dynamic> json) {
    return Evidencia(id: json["id"], nome: json["nome"]);
  }
}
