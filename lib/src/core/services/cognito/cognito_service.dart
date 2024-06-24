import 'package:amazon_cognito_identity_dart_2/cognito.dart';

/// Representation of AWS Cognito Service
abstract interface class CognitoService {
  CognitoUserPool get userPool;
  CognitoUser? get user;
  CognitoUserSession? get userSession;

  /// Initialize [CognitoUserPool] of [CognitoService]
  void initialize({
    required String userPoolId,
    required String clientId,
  });

  /// Initialize [CognitoUser] with [CognitoUser]'s current [CognitoUserSession]
  Future<void> initializeUserSession({
    required String username,
    required String idToken,
    required String accessToken,
    required String refreshToken,
  });

  /// Authenticate [CognitoUser] with [CognitoUser]'s new [CognitoUserSession]
  Future<void> authenticateUserSession({
    required String username,
    required AuthenticationDetails authenticationDetails,
  });

  Future<void> refreshSession();

  Future<String?> getAccessToken();
}
