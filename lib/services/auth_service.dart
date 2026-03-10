import 'package:dio/dio.dart';
import 'package:inspecao_veicular_petroeng/helpers/urls.dart';
import 'package:inspecao_veicular_petroeng/models/success_api_result.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: Urls.apiBaseUrl));

  Future<String?> login({required String email, required String senha}) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        "/auth/login",
        data: {"email": email, "senha": senha},
      );
      final result = SuccessApiResult.fromJson(
        response.data!,
        (dados) => dados as String,
      );
      return result.dados;
    } catch (e) {
      return null;
    }
  }
}
