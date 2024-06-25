part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthLoggedIn extends AuthEvent {
  const AuthLoggedIn({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [
        email,
        password,
      ];
}

final class AuthLoggedOut extends AuthEvent {
  const AuthLoggedOut();

  @override
  List<Object> get props => [];
}

final class AuthStatusChecked extends AuthEvent {
  const AuthStatusChecked();

  @override
  List<Object> get props => [];
}
