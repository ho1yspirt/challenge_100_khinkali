import 'package:amazon_cognito_identity_dart_2/cognito.dart';

import '../../../../core/services/cognito/cognito_service.dart';
import '../datasources/auth_datasource.dart';

abstract interface class AuthRepository {
  Future<(CognitoIdToken, CognitoAccessToken, CognitoRefreshToken?)> login({
    required String email,
    required String password,
  });

  Future<void> saveSessionData({
    required CognitoIdToken idToken,
    required CognitoAccessToken accessToken,
    CognitoRefreshToken? refreshToken,
    required String username,
  });

  Future<CognitoUserSession?> getSession();
}

class AuthRepository$Impl implements AuthRepository {
  const AuthRepository$Impl(
    this.cognitoService,
    this.authDataSource,
  );

  final CognitoService cognitoService;
  final AuthDataSource authDataSource;

  @override
  Future<(CognitoIdToken, CognitoAccessToken, CognitoRefreshToken?)> login({
    required String email,
    required String password,
  }) async {
    try {
      cognitoService.initializeUser(username: email);
      final AuthenticationDetails authenticationDetails = AuthenticationDetails(
        username: email,
        password: password,
      );

      cognitoService.initializeSession(
        userSession: (await cognitoService.user.authenticateUser(
          authenticationDetails,
        ))!,
      );

      return (
        cognitoService.userSession.idToken,
        cognitoService.userSession.accessToken,
        cognitoService.userSession.refreshToken,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveSessionData({
    required CognitoIdToken idToken,
    required CognitoAccessToken accessToken,
    CognitoRefreshToken? refreshToken,
    required String username,
  }) async {
    try {
      await authDataSource.setIdToken(idToken.jwtToken!);
      await authDataSource.setAccessToken(accessToken.jwtToken!);
      await authDataSource.setRefreshToken(refreshToken!.token!);
      await authDataSource.setUsername(username);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CognitoUserSession?> getSession() async {
    try {
      try {
        // get session from cognito service
        return cognitoService.userSession;
      } catch (e) {
        _refreshSession();
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<CognitoUserSession?> _refreshSession() async {
    try {
      // get username and refresh token from previous application session for cognito session
      final String username = await authDataSource.getUsername();
      final CognitoRefreshToken refreshToken = CognitoRefreshToken(
        await authDataSource.getRefreshToken(),
      );

      // initialize cognito user and cognito session with previous application session data
      cognitoService.initializeUser(username: username);
      cognitoService.initializeSession(
        userSession: (await cognitoService.user.refreshSession(refreshToken))!,
      );

      return cognitoService.userSession;
    } catch (e) {
      cognitoService.initializeUser(username: 'anonymous');

      return null;
    }
  }
}
