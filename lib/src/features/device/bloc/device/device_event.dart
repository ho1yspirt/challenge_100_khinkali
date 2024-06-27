part of 'device_bloc.dart';

sealed class DeviceEvent extends Equatable {
  const DeviceEvent();

  @override
  List<Object> get props => [];
}

final class DeviceFetched extends DeviceEvent {
  const DeviceFetched({
    required this.id,
  });

  final String id;

  @override
  List<Object> get props => [id];
}

final class DeviceCreated extends DeviceEvent {
  const DeviceCreated({
    required this.deviceModel,
    required this.userLocation,
  });

  final DeviceModel deviceModel;
  final LocationModel userLocation;

  @override
  List<Object> get props => [deviceModel];
}
