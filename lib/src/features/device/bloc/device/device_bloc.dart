import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:learn_flutter_aws/src/core/utils/logger.dart';
import 'package:learn_flutter_aws/src/features/Device/data/repositories/device_repository.dart';
import 'package:learn_flutter_aws/src/features/device/data/models/device_model.dart';

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final DeviceRepository _DeviceRepository;

  DeviceBloc(this._DeviceRepository) : super(DeviceInitial()) {
    on<DeviceEvent>(
      (event, emit) => switch (event) {
        DeviceFetched() => _getDevice(event, emit),
      },
    );
  }

  FutureOr<void> _getDevice(event, emit) async {
    try {
      emit(DeviceLoading());

      final DeviceModel deviceModel = await _DeviceRepository.getDevice(id: event.id);

      emit(DeviceFetchSuccess(deviceModel: deviceModel));
    } catch (error, stackTrace) {
      logger.e('AuthBloc', error: error, stackTrace: stackTrace);

      emit(DeviceFuiluer());
    }
  }
}
