import '../../../../core/services/appsync/appsync_service.dart';

abstract interface class DeviceDatasource {
  const DeviceDatasource(this.appSyncService);

  final AppSyncService$Impl appSyncService;

  Future<void> createDevice();
}
