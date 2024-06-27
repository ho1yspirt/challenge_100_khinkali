import 'package:learn_flutter_aws/src/core/utils/logger.dart';
import 'package:learn_flutter_aws/src/features/device/data/datasources/device_datasource.dart';
import 'package:learn_flutter_aws/src/features/device/data/models/device_model.dart';

abstract interface class DeviceRepository {
  Future<DeviceModel> getDevice({
    required String id,
  });

  Future<List<DeviceModel>> listDevices();
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
        result['users'].length,
        (index) => DeviceModel.fromMap(result['users'][index]),
      );

      return deviceModelList;
    } catch (e) {
      rethrow;
    }
  }
}
