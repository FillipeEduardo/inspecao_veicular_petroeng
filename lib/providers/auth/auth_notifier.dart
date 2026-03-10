import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspecao_veicular_petroeng/providers/auth/auth_repository.dart';
import "package:inspecao_veicular_petroeng/providers/auth/auth_state.dart";

class AuthNotifier extends AsyncNotifier<AuthState> {
  AuthRepository get _repo => ref.read(authRepositoryProvider);

  @override
  Future<AuthState> build() async {
    final token = await _repo.readToken();
    if (token != null) return AuthState.authenticated(token);
    return AuthState.unauthenticated();
  }

  Future<void> login(String token) async {
    await _repo.saveToken(token);
    state = AsyncData(AuthState.authenticated(token));
  }

  Future<void> logout() async {
    await _repo.deleteToken();
    state = AsyncData(AuthState.unauthenticated());
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
