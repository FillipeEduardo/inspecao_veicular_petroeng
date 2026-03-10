class Veiculo {
  int id;
  String placa;
  int ano;
  String modelo;

  Veiculo({
    required this.ano,
    required this.id,
    required this.modelo,
    required this.placa,
  });

  factory Veiculo.fromJson(Map<String, dynamic> json) {
    return Veiculo(
      ano: json["ano"],
      id: json["id"],
      modelo: json["modelo"],
      placa: json["placa"],
    );
  }
}
