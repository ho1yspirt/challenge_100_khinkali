import 'package:amazon_cognito_identity_dart_2/cognito.dart';

import '../../../../core/services/cognito/cognito_service.dart';

class CognitoService$Impl implements CognitoService {
  CognitoService$Impl();

  late final CognitoUserPool _userPool;
  CognitoUser? _user;
  CognitoUserSession? _userSession;

  @override
  CognitoUserPool get userPool => _userPool;

  @override
  CognitoUser? get user => _user;

  @override
  CognitoUserSession? get userSession => _userSession;

  @override
  void initialize({
    required String userPoolId,
    required String clientId,
  }) {
    _userPool = CognitoUserPool(userPoolId, clientId);
  }

  @override
  Future<void> initializeUserSession({
    required String username,
    required String idToken,
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      _user = CognitoUser(username, userPool);
      _userSession = CognitoUserSession(
        CognitoIdToken(idToken),
        CognitoAccessToken(accessToken),
        refreshToken: CognitoRefreshToken(refreshToken),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> authenticateUserSession({
    required String username,
    required AuthenticationDetails authenticationDetails,
  }) async {
    try {
      _user = CognitoUser(username, userPool);
      _userSession = await user?.authenticateUser(authenticationDetails);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> refreshSession() async {
    try {
      final CognitoUserSession? currentSession = await user?.getSession();

      if (currentSession != null && currentSession.isValid()) {
        _userSession = await _user?.refreshSession(currentSession.refreshToken!);
      }
    } catch (e) {
      rethrow;
    }
  }
}
