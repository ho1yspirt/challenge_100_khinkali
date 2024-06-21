import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/logger.dart';
import '../../data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(const AuthUnautheticated()) {
    on<AuthStatusChecked>((event, emit) async {
      try {
        final CognitoUserSession? session = await authRepository.getSession();

        if (session == null) {
          emit(const AuthUnautheticated());
        } else {
          if (session.isValid()) {
            emit(const AuthAuthenticated());
          } else {
            emit(const AuthUnautheticated());
          }
        }
      } catch (error, stackTrace) {
        logger.e('AuthBloc', error: error, stackTrace: stackTrace);

        emit(AuthUnautheticated(
          hasError: true,
          error: error,
        ));
      }
    });

    on<AuthLoggedIn>((event, emit) async {
      try {
        emit(const AuthProcessing());

        final (
          CognitoIdToken,
          CognitoAccessToken,
          CognitoRefreshToken?,
        ) sessionData = await authRepository.login(
          email: event.email,
          password: event.password,
        );

        await authRepository.saveSessionData(
          idToken: sessionData.$1,
          accessToken: sessionData.$2,
          refreshToken: sessionData.$3,
          username: event.email,
        );

        emit(const AuthAuthenticated());
      } catch (error, stackTrace) {
        logger.e('AuthBloc', error: error, stackTrace: stackTrace);

        emit(AuthUnautheticated(
          hasError: true,
          error: error,
        ));
      }
    });
  }
}
