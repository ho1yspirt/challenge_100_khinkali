import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:learn_flutter_aws/src/core/services/cognito/cognito_service.dart';

abstract interface class AppSyncService {
  void initialize({
    required String httpLinkUrl,
    required String apiKey,
  });

  Future<QueryResult> query(
    QueryOptions options,
  );

  Future<QueryResult> mutate(
    MutationOptions options,
  );

  Future<Stream<QueryResult>> subscribe(
    SubscriptionOptions options,
  );

  ObservableQuery watchQuery(WatchQueryOptions options);

  ObservableQuery watchMutation(WatchQueryOptions options);
}

class AppSyncService$Impl implements AppSyncService {
  AppSyncService$Impl(this._cognitoService);

  final CognitoService _cognitoService;

  late final HttpLink _httpLink;
  late final AuthLink _authLink;
  late final GraphQLClient _graphQLClient;

  @override
  void initialize({
    required String httpLinkUrl,
    required String apiKey,
  }) {
    _httpLink = HttpLink(httpLinkUrl, defaultHeaders: {
      'x-api-key': apiKey,
      'Content-Type': 'application/graphql',
    });
    _authLink = AuthLink(
      getToken: () async => 'Bearer ${await _cognitoService.getAccessToken()}',
    );

    final Link link = _authLink.concat(_httpLink);

    _graphQLClient = GraphQLClient(
      link: link,
      cache: GraphQLCache(
        store: HiveStore(),
      ),
    );
  }

  @override
  Future<QueryResult<Object?>> query(options) async => await _graphQLClient.query(options);

  @override
  Future<QueryResult<Object?>> mutate(options) async => await _graphQLClient.mutate(options);

  @override
  Future<Stream<QueryResult<Object?>>> subscribe(options) async => _graphQLClient.subscribe(options);

  @override
  ObservableQuery watchQuery(WatchQueryOptions options) => _graphQLClient.watchQuery(options);

  @override
  ObservableQuery watchMutation(options) => _graphQLClient.watchMutation(options);
}
