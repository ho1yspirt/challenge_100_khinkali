import 'package:amazon_cognito_identity_dart_2/cognito.dart';

abstract interface class CognitoService {
  CognitoUserPool get userPool;
  CognitoUser get user;
  CognitoUserSession get userSession;

  void initialize({
    required String userPoolId,
    required String clientId,
  });

  void initializeUser({
    required String username,
  });

  void initializeSession({
    required CognitoUserSession userSession,
  });
}
