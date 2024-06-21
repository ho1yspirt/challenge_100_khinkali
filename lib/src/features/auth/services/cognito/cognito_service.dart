import 'package:amazon_cognito_identity_dart_2/cognito.dart';

import '../../../../core/services/cognito/cognito_service.dart';

class CognitoService$Impl implements CognitoService {
  CognitoService$Impl();

  late final CognitoUserPool _userPool;
  late CognitoUser _user;
  late CognitoUserSession _userSession;

  @override
  CognitoUserPool get userPool => _userPool;

  @override
  CognitoUser get user => _user;

  @override
  CognitoUserSession get userSession => _userSession;

  @override
  void initialize({
    required String userPoolId,
    required String clientId,
  }) {
    _userPool = CognitoUserPool(userPoolId, clientId);
  }

  @override
  void initializeUser({
    required String username,
  }) =>
      _user = CognitoUser(username, userPool);

  @override
  void initializeSession({
    required CognitoUserSession userSession,
  }) =>
      _userSession = userSession;
}
