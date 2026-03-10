import 'package:inspecao_veicular_petroeng/models/api_result.dart';

class SuccessApiResult<T> extends Apiresult {
  final String mensagem;
  final T dados;

  SuccessApiResult({
    required this.dados,
    required this.mensagem,
    required super.httpStatusCode,
  });

  factory SuccessApiResult.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) {
    return SuccessApiResult<T>(
      httpStatusCode: json['httpStatusCode'] as int,
      mensagem: json['mensagem'] as String,
      dados: fromJsonT(json['dados']),
    );
  }
}
