class StatusInspecao {
  final int id;
  final String nome;

  StatusInspecao({required this.id, required this.nome});

  factory StatusInspecao.fromJson(Map<String, dynamic> json) {
    return StatusInspecao(id: json["id"], nome: json["nome"]);
  }
}
