import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/helpers/urls.dart';
import 'package:inspecao_veicular_petroeng/providers/services/auth_interceptor.dart';
import 'package:inspecao_veicular_petroeng/services/veiculo_service.dart';

final veiculoServiceProvider = Provider<VeiculoService>((ref) {
  final dio = Dio(
    BaseOptions(baseUrl: String.fromEnvironment(Urls.apiBaseUrl)),
  );
  dio.interceptors.add(AuthInterceptor(ref));
  return VeiculoService(dio);
});
