import '../datasources/auth_datasource.dart';

abstract interface class AuthRepository {
  Future<void> login({
    required String email,
    required String password,
  });

  Future<void> logout();
}

class AuthRepository$Impl implements AuthRepository {
  const AuthRepository$Impl(
    this._authDataSource,
  );

  final AuthDataSource _authDataSource;

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {} catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {} catch (e) {
      rethrow;
    }
  }
}
