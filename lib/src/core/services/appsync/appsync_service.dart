import 'package:graphql_flutter/graphql_flutter.dart';

abstract interface class AppSyncService {
  void initialize({
    required String httpLinkUrl,
    required String authToken,
  });

  Future<QueryResult> query();

  Future<QueryResult> mutate();

  Future<Stream<QueryResult>> subscribe();
}

class AppSyncService$Impl implements AppSyncService {
  AppSyncService$Impl();

  late final HttpLink httpLink;
  late final AuthLink authLink;
  late final HiveStore hiveStore;
  late final GraphQLCache graphQLCache;
  late final GraphQLClient graphQLClient;

  @override
  void initialize({
    required String httpLinkUrl,
    required String authToken,
  }) {
    httpLink = HttpLink(httpLinkUrl);
    authLink = AuthLink(getToken: () => 'Bearer $authToken');
    hiveStore = HiveStore();
    graphQLCache = GraphQLCache(store: HiveStore());

    final Link link = authLink.concat(httpLink);

    graphQLClient = GraphQLClient(link: link, cache: graphQLCache);
  }

  @override
  Future<QueryResult<Object?>> mutate() {
    // TODO: implement mutate
    throw UnimplementedError();
  }

  @override
  Future<QueryResult<Object?>> query() {
    // TODO: implement query
    throw UnimplementedError();
  }

  @override
  Future<Stream<QueryResult<Object?>>> subscribe() {
    // TODO: implement subscribe
    throw UnimplementedError();
  }
}
