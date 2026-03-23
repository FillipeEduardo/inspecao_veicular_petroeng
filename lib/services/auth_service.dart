import 'package:dio/dio.dart';
import 'package:inspecao_veicular_petroeng/helpers/urls.dart';
import 'package:inspecao_veicular_petroeng/models/api_result.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: Urls.apiBaseUrl));

  Future<Apiresult<String>> login({
    required String email,
    required String senha,
  }) async {
    try {
      final response = await _dio.post(
        "/auth/login",
        data: {"email": email, "senha": senha},
      );
      final result = Apiresult.fromJson(
        response.data!,
        fromJsonT: (dados) => dados as String,
      );
      return result;
    } on DioException catch (ex) {
      return Apiresult.fromJson(ex.response!.data);
    }
  }
}
