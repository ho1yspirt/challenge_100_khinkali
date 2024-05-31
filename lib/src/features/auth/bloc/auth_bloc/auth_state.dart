part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthProcessing extends AuthState {
  const AuthProcessing();
}

final class AuthAuthenticated extends AuthState {
  const AuthAuthenticated();
}

final class AuthUnautheticated extends AuthState {
  const AuthUnautheticated({
    this.hasError = false,
    this.error,
  });

  final bool hasError;
  final Object? error;

  @override
  List<Object> get props => [
        hasError,
        if (error != null) error!,
      ];
}
