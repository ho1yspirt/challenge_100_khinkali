part of 'settings_bloc.dart';

final class SettingsState extends Equatable {
  const SettingsState({
    required this.settingsModel,
  });

  final SettingsModel settingsModel;

  SettingsState copyWith({
    SettingsModel? settingsModel,
  }) =>
      SettingsState(
        settingsModel: settingsModel ?? this.settingsModel,
      );

  @override
  List<Object> get props => [
        settingsModel,
      ];
}
