import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../data/models/app_settings_model.dart';
import '../../data/repositories/app_settings_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppSettingsBloc extends Bloc<AppEvent, AppState> {
  final AppSettingsRepository appRepository;

  AppSettingsBloc(
    this.appRepository,
  ) : super(AppState(
          appSettingsModel: appRepository.getCurrentSettingsModel(),
        )) {
    on<AppLocaleChanged>((event, emit) async {
      await appRepository.setCurrentLocale(event.locale);
      emit(state.copyWith(
        settingsModel: appRepository.getCurrentSettingsModel(),
      ));
    });

    on<AppThemeModeChanged>((event, emit) async {
      await appRepository.setCurrentThemeMode(event.themeMode);
      emit(state.copyWith(
        settingsModel: appRepository.getCurrentSettingsModel(),
      ));
    });
  }
}
