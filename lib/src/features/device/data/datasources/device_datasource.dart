import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:learn_flutter_aws/src/core/services/appsync/appsync_service.dart';
import 'package:learn_flutter_aws/src/features/user/data/graphql_schemas/user_schema.dart';

abstract interface class DeviceDatasource {
  Future<Map<String, dynamic>> getDevice({
    required String id,
  });

  Future<Map<String, dynamic>> listDevices();
}

class DeviceDatasource$Impl implements DeviceDatasource {
  const DeviceDatasource$Impl(this._appSyncService);

  final AppSyncService _appSyncService;

  @override
  Future<Map<String, dynamic>> getDevice({required String id}) async {
    try {
      final QueryResult result = await _appSyncService.query(
        QueryOptions(
          document: gql(getUserQuery(
            withAvatar: false,
            withEmail: false,
            withJoinDate: false,
            withGroupName: false,
            withStatus: false,
            withPhoneNumber: false,
          )),
          variables: {
            'input': {
              'id': id,
            }
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      }

      return result.data?['getUser'];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> listDevices() async {
    try {
      final QueryResult result = await _appSyncService.query(
        QueryOptions(
          document: gql(listUsersQuery(
            withAvatar: false,
            withEmail: false,
            withJoinDate: false,
            withGroupName: false,
            withStatus: false,
            withPhoneNumber: false,
          )),
          variables: const {
            'input': {
              'filter': {},
            }
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      }

      return result.data?['listUsers'];
    } catch (e) {
      rethrow;
    }
  }
}
