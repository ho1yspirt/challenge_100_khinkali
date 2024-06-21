import '../../../../core/services/appsync/appsync.dart';

abstract interface class DeviceDatasource {
  const DeviceDatasource(this.appSyncService);

  final AppSyncService appSyncService;

  Future<void> createDevice();
}
