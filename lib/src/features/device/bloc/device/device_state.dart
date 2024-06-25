part of 'device_bloc.dart';

sealed class DeviceState extends Equatable {
  const DeviceState();

  @override
  List<Object> get props => [];
}

final class DeviceInitial extends DeviceState {}

final class DeviceLoading extends DeviceState {}

final class DeviceFetchSuccess extends DeviceState {
  const DeviceFetchSuccess({
    required this.deviceModel,
  });

  final DeviceModel deviceModel;

  @override
  List<Object> get props => [deviceModel];
}

final class DeviceFuiluer extends DeviceState {}
