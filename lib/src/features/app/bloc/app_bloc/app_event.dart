part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

final class AppLocaleChanged extends AppEvent {
  const AppLocaleChanged(this.locale);

  final String locale;

  @override
  List<Object> get props => [locale];
}

final class AppThemeModeChanged extends AppEvent {
  const AppThemeModeChanged(this.themeMode);

  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];
}
