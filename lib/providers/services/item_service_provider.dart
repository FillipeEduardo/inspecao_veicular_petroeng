import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/helpers/urls.dart';
import 'package:inspecao_veicular_petroeng/providers/services/auth_interceptor.dart';
import 'package:inspecao_veicular_petroeng/services/item_service.dart';

final itemServiceProvider = Provider<ItemService>((ref) {
  final dio = Dio(BaseOptions(baseUrl: Urls.apiBaseUrl));
  dio.interceptors.add(AuthInterceptor(ref));
  return ItemService(dio);
});
