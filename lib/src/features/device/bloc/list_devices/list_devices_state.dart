part of 'list_devices_bloc.dart';

sealed class ListDevicesState extends Equatable {
  const ListDevicesState();

  @override
  List<Object> get props => [];
}

final class ListDevicesInitial extends ListDevicesState {}

final class ListDevicesLoading extends ListDevicesState {}

final class ListDevicesFetchSuccess extends ListDevicesState {
  const ListDevicesFetchSuccess({
    required this.deviceModelList,
  });

  final List<DeviceModel> deviceModelList;

  @override
  List<Object> get props => [deviceModelList];
}

final class ListDevicesFuiluer extends ListDevicesState {}
