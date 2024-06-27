import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:learn_flutter_aws/src/core/utils/logger.dart';
import 'package:learn_flutter_aws/src/features/device/data/models/device_model.dart';
import 'package:learn_flutter_aws/src/features/device/data/repositories/device_repository.dart';

part 'list_devices_event.dart';
part 'list_devices_state.dart';

class ListDevicesBloc extends Bloc<ListDevicesEvent, ListDevicesState> {
  final DeviceRepository _deviceRepository;

  ListDevicesBloc(this._deviceRepository) : super(ListDevicesInitial()) {
    on<ListDevicesEvent>(
      (event, emit) => switch (event) {
        ListDevicesFetched() => _listDevices(event, emit),
      },
    );
  }

  FutureOr<void> _listDevices(event, emit) async {
    try {
      emit(ListDevicesLoading());

      final List<DeviceModel> deviceModelList = await _deviceRepository.listDevices();

      emit(ListDevicesFetchSuccess(deviceModelList: deviceModelList));
    } catch (error, stackTrace) {
      logger.e('AuthBloc', error: error, stackTrace: stackTrace);

      emit(ListDevicesFuiluer());
    }
  }
}
