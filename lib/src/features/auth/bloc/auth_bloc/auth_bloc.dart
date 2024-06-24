import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/logger.dart';
import '../../data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const Unautheticated()) {
    on<AuthStatusChecked>((event, emit) async {
      try {
        // Get possible restored cognito session from previous application session
        final CognitoUserSession? session = await _authRepository.restoreSession();

        // Logout user if restored cognito session is forgotten
        if (session == null) {
          emit(const Unautheticated());
          return;
        }

        // Restore user session from cognito session in application session
        if (session.isValid()) {
          emit(const Authenticated());
          return;
        }

        // If cognito session is invalid try to refresh it
        final CognitoUserSession? refreshedSession = await _authRepository.restoreSession();

        if (refreshedSession?.isValid() ?? false) {
          emit(const Authenticated());
        } else {
          // Logout user if failed to refresh cognito session
          emit(const Unautheticated());
        }
      } catch (error, stackTrace) {
        logger.e('AuthBloc', error: error, stackTrace: stackTrace);

        emit(Unautheticated(
          hasError: true,
          error: error,
        ));
      }
    });

    on<AuthLoggedIn>((event, emit) async {
      try {
        emit(const AuthProcessing());

        await _authRepository.login(
          email: event.email,
          password: event.password,
        );

        emit(const Authenticated());
      } catch (error, stackTrace) {
        logger.e('AuthBloc', error: error, stackTrace: stackTrace);

        emit(Unautheticated(
          hasError: true,
          error: error,
        ));
      }
    });
  }
}
