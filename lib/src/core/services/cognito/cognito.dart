import 'package:amazon_cognito_identity_dart_2/cognito.dart';

class CognitoService {
  CognitoService();

  late final CognitoUserPool userPool;
  late CognitoUser user;
  late CognitoUserSession cognitoSession;

  void initialize({
    required String userPoolId,
    required String clientId,
  }) {
    userPool = CognitoUserPool(userPoolId, clientId);
  }

  void initializeUser({required String username}) => user = CognitoUser(username, userPool);

  void initializeSession({required CognitoUserSession session}) => cognitoSession = session;
}
