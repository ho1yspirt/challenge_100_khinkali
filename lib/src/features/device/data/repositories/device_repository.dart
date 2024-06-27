import 'package:learn_flutter_aws/src/core/utils/logger.dart';
import 'package:learn_flutter_aws/src/features/device/data/datasources/device_datasource.dart';
import 'package:learn_flutter_aws/src/features/device/data/models/device_model.dart';

abstract interface class DeviceRepository {
  Future<DeviceModel> getDevice({
    required String id,
  });

  Future<List<DeviceModel>> listDevices();

  Future<DeviceModel> createDevice({
    required DeviceModel deviceModel,
    required LocationModel userLocation,
  });
}

class DeviceRepository$Impl implements DeviceRepository {
  const DeviceRepository$Impl(this._deviceDatasource);

  final DeviceDatasource _deviceDatasource;

  @override
  Future<DeviceModel> getDevice({required String id}) async {
    try {
      final Map<String, dynamic> result = await _deviceDatasource.getDevice(id: id);

      logger.d(result);

      return DeviceModel.fromMap(result);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<DeviceModel>> listDevices() async {
    try {
      final Map<String, dynamic> result = await _deviceDatasource.listDevices();

      final List<DeviceModel> deviceModelList = List.generate(
        result['devices'].length,
        (index) => DeviceModel.fromMap(result['devices'][index]),
      );

      return deviceModelList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DeviceModel> createDevice({
    required DeviceModel deviceModel,
    required LocationModel userLocation,
  }) async {
    try {
      final Map<String, dynamic> result = await _deviceDatasource.createDevice(
        address: deviceModel.address,
        lat: deviceModel.location!.lat,
        lon: deviceModel.location!.lon,
        notes: deviceModel.notes,
        // TODO; implement organization to [DeviceModel]
        organization: '',
        userLocationLat: userLocation.lat,
        userLocationLon: userLocation.lon,
      );

      logger.d(result);

      return DeviceModel.fromMap(result);
    } catch (e) {
      rethrow;
    }
  }
}
