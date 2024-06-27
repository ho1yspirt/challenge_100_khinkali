import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:learn_flutter_aws/src/core/services/appsync/appsync_service.dart';
import 'package:learn_flutter_aws/src/features/device/data/graphql_schemas/device_schema.dart';

abstract interface class DeviceDatasource {
  Future<Map<String, dynamic>> getDevice({
    required String id,
  });

  Future<Map<String, dynamic>> listDevices();

  Future<Map<String, dynamic>> createDevice({
    String? address,
    String deviceType = 'Terminal',
    required double lat,
    required double lon,
    String? notes,
    String? organization,
    required double userLocationLat,
    required double userLocationLon,
  });
}

class DeviceDatasource$Impl implements DeviceDatasource {
  const DeviceDatasource$Impl(this._appSyncService);

  final AppSyncService _appSyncService;

  @override
  Future<Map<String, dynamic>> getDevice({required String id}) async {
    try {
      final QueryResult result = await _appSyncService.query(
        QueryOptions(
          document: gql(getDeviceQuery),
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

      return result.data?['getDevice'];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> listDevices() async {
    try {
      final QueryResult result = await _appSyncService.query(
        QueryOptions(
          document: gql(listDevicesQuery),
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

      return result.data?['listDevices'];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> createDevice({
    String? address,
    String deviceType = 'Terminal',
    required double lat,
    required double lon,
    String? notes,
    String? organization,
    required double userLocationLat,
    required double userLocationLon,
  }) async {
    try {
      final QueryResult result = await _appSyncService.mutate(
        MutationOptions(document: gql(createDeviceMutation), variables: {
          'input': {
            'address': address,
            'deviceType': deviceType,
            'location': {
              'lat': lat,
              'lon': lon,
            },
            'notes': notes,
            'organization': organization,
            'userLocation': {
              'lat': userLocationLat,
              'lon': userLocationLon,
            }
          }
        }),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      }

      return result.data?['createDeviceMutation'];
    } catch (e) {
      rethrow;
    }
  }
}
