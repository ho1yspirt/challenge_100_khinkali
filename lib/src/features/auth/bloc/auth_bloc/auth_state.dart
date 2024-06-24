part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthProcessing extends AuthState {
  const AuthProcessing();
}

final class Authenticated extends AuthState {
  const Authenticated();
}

final class Unautheticated extends AuthState {
  const Unautheticated({
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
