class Item {
  final int id;
  final String nome;

  Item({required this.id, required this.nome});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(id: json["id"], nome: json["nome"]);
  }
}
