import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract interface class AuthDataSource {
  Future<void> setIdToken(String value);
  Future<void> setAccessToken(String value);
  Future<void> setRefreshToken(String value);
  Future<void> setUsername(String value);

  Future<String> getIdToken();
  Future<String> getAccessToken();
  Future<String> getRefreshToken();
  Future<String> getUsername();
}

class AuthDataSource$Impl implements AuthDataSource {
  const AuthDataSource$Impl(
    this.flutterSecureStorage,
  );

  final FlutterSecureStorage flutterSecureStorage;

  static const cognitoIdTokenKey = 'cognitoIdKey';
  static const cognitoAccessTokenKey = 'cognitoAccessKey';
  static const cognitoRefreshTokenKey = 'cognitoRefreshKey';
  static const usernameKey = 'usernameKey';

  @override
  Future<void> setAccessToken(String value) async {
    try {
      await flutterSecureStorage.write(key: cognitoAccessTokenKey, value: value);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> setIdToken(String value) async {
    try {
      await flutterSecureStorage.write(key: cognitoIdTokenKey, value: value);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> setRefreshToken(String value) async {
    try {
      await flutterSecureStorage.write(key: cognitoRefreshTokenKey, value: value);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> setUsername(String value) async {
    try {
      await flutterSecureStorage.write(key: usernameKey, value: value);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> getAccessToken() async {
    try {
      return (await flutterSecureStorage.read(key: cognitoAccessTokenKey))!;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> getIdToken() async {
    try {
      return (await flutterSecureStorage.read(key: cognitoIdTokenKey))!;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> getRefreshToken() async {
    try {
      return (await flutterSecureStorage.read(key: cognitoRefreshTokenKey))!;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> getUsername() async {
    try {
      return (await flutterSecureStorage.read(key: usernameKey))!;
    } catch (e) {
      rethrow;
    }
  }
}
