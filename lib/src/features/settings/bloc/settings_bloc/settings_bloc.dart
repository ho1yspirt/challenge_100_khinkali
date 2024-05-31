import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter_aws/src/features/settings/data/models/settings_model.dart';
import 'package:learn_flutter_aws/src/features/settings/data/repositories/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final ISettingsRepository settingsRepository;

  SettingsBloc(
    this.settingsRepository,
  ) : super(SettingsState(
          settingsModel: settingsRepository.getCurrentSettingsModel(),
        )) {
    on<SettingsLocaleChanged>((event, emit) async {
      await settingsRepository.setCurrentLocale(event.locale);
      emit(state.copyWith(
        settingsModel: settingsRepository.getCurrentSettingsModel(),
      ));
    });

    on<SettingsThemeModeChanged>((event, emit) async {
      await settingsRepository.setCurrentThemeMode(event.themeMode);
      emit(state.copyWith(
        settingsModel: settingsRepository.getCurrentSettingsModel(),
      ));
    });
  }
}
