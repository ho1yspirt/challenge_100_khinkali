part of 'app_bloc.dart';

final class AppState extends Equatable {
  const AppState({
    required this.appSettingsModel,
  });

  final AppSettingsModel appSettingsModel;

  AppState copyWith({
    AppSettingsModel? settingsModel,
  }) =>
      AppState(
        appSettingsModel: settingsModel ?? appSettingsModel,
      );

  @override
  List<Object> get props => [
        appSettingsModel,
      ];
}
