part of 'list_devices_bloc.dart';

sealed class ListDevicesEvent extends Equatable {
  const ListDevicesEvent();

  @override
  List<Object> get props => [];
}

final class ListDevicesFetched extends ListDevicesEvent {
  const ListDevicesFetched();

  @override
  List<Object> get props => [];
}
