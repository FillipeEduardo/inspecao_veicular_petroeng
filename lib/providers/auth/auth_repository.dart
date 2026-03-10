import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepository {
  final FlutterSecureStorage _storage;

  AuthRepository(this._storage);

  Future<String?> readToken() => _storage.read(key: 'jwt_token');

  Future<void> saveToken(String token) =>
      _storage.write(key: 'jwt_token', value: token);

  Future<void> deleteToken() => _storage.delete(key: 'jwt_token');
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(const FlutterSecureStorage());
});
