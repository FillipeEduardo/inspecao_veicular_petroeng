import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/helpers/urls.dart';
import 'package:inspecao_veicular_petroeng/providers/services/auth_interceptor.dart';
import 'package:inspecao_veicular_petroeng/services/status_inspecao_service.dart';

final statusInspecaoServiceProvider = Provider<StatusInspecaoService>((ref) {
  final dio = Dio(BaseOptions(baseUrl: Urls.apiBaseUrl));
  dio.interceptors.add(AuthInterceptor(ref));
  return StatusInspecaoService(dio);
});
