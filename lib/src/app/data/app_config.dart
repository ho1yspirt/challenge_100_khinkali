import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract interface class IAppConfig {
  String get host;

  //* AWS start
  String get awsRegion;

  // appSync
  String get appSyncBaseUrlEndpoint;
  String get appSyncApiKey;

  // cognito
  String get cognitoClientId;
  String get cognitoUserPoolId;
  String get cognitoIdentityPoolId;
  //* AWS end

  // integrations
  // String get oneSignalId;

  // others
  String get appWebsiteBaseUrl;
}

class ProdAppConfig implements IAppConfig {
  @override
  String get host => 'prod';

  @override
  String get awsRegion => dotenv.env['REGION'] ?? '';

  @override
  String get appSyncApiKey => dotenv.env['APPSYNC_API_KEY'] ?? '';

  @override
  String get appSyncBaseUrlEndpoint => dotenv.env['APPSYNC_ENDPOINT'] ?? '';

  @override
  String get cognitoClientId => dotenv.env['COGNITO_CLIENT_ID'] ?? '';

  @override
  String get cognitoIdentityPoolId => dotenv.env['COGNITO_IDENTITY_POOL_ID'] ?? '';

  @override
  String get cognitoUserPoolId => dotenv.env['COGNITO_USER_POOL_ID'] ?? '';

  @override
  String get appWebsiteBaseUrl => dotenv.env['WEBSITE_DOMAIN'] ?? '';
}

class DevAppConfig implements IAppConfig {
  @override
  String get host => 'dev';

  @override
  String get awsRegion => dotenv.env['BETA_REGION'] ?? '';

  @override
  String get appSyncApiKey => dotenv.env['BETA_APPSYNC_API_KEY'] ?? '';

  @override
  String get appSyncBaseUrlEndpoint => dotenv.env['BETA_APPSYNC_ENDPOINT'] ?? '';

  @override
  String get cognitoClientId => dotenv.env['BETA_COGNITO_CLIENT_ID'] ?? '';

  @override
  String get cognitoIdentityPoolId => dotenv.env['BETA_COGNITO_IDENTITY_POOL_ID'] ?? '';

  @override
  String get cognitoUserPoolId => dotenv.env['BETA_COGNITO_USER_POOL_ID'] ?? '';

  @override
  String get appWebsiteBaseUrl => dotenv.env['BETA_WEBSITE_DOMAIN'] ?? '';
}

class TestAppConfig implements IAppConfig {
  @override
  String get host => 'test';

  @override
  String get awsRegion => dotenv.env['BETA_REGION'] ?? '';

  @override
  String get appSyncApiKey => dotenv.env['BETA_APPSYNC_API_KEY'] ?? '';

  @override
  String get appSyncBaseUrlEndpoint => dotenv.env['BETA_APPSYNC_ENDPOINT'] ?? '';

  @override
  String get cognitoClientId => dotenv.env['BETA_COGNITO_CLIENT_ID'] ?? '';

  @override
  String get cognitoIdentityPoolId => dotenv.env['BETA_COGNITO_IDENTITY_POOL_ID'] ?? '';

  @override
  String get cognitoUserPoolId => dotenv.env['BETA_COGNITO_USER_POOL_ID'] ?? '';

  @override
  String get appWebsiteBaseUrl => dotenv.env['BETA_WEBSITE_DOMAIN'] ?? '';
}
