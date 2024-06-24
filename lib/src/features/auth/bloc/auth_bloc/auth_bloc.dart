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
        final CognitoUserSession? session = await _authRepository.restore();

        if (session == null) {
          emit(const Unautheticated());
        } else {
          if (session.isValid()) {
            emit(const Authenticated());
          } else {
            // TODO: refresh session with tokens
            emit(const Unautheticated());
          }
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
