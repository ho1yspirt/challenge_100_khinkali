import 'package:graphql_flutter/graphql_flutter.dart';

class AppSyncService {
  AppSyncService();

  late final HttpLink httpLink;
  late final AuthLink authLink;
  late final HiveStore hiveStore;
  late final GraphQLCache graphQLCache;
  late final GraphQLClient graphQLClient;

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

  // void authorize({
  //   required String authToken,
  // }) {

  // }
}
