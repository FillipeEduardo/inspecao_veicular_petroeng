import 'package:dio/dio.dart';
import 'package:inspecao_veicular_petroeng/helpers/urls.dart';
import 'package:inspecao_veicular_petroeng/models/api_result.dart';
import 'package:inspecao_veicular_petroeng/models/success_api_result.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: Urls.apiBaseUrl));

  Future<Apiresult> login({
    required String email,
    required String senha,
  }) async {
    try {
      final response = await _dio.post(
        "/auth/login",
        data: {"email": email, "senha": senha},
      );
      final result = SuccessApiResult.fromJson(
        response.data!,
        (dados) => dados as String,
      );
      return result;
    } on DioException catch (ex) {
      return Apiresult.fromJson(ex.response!.data);
    }
  }
}
