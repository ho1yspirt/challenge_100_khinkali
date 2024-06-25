import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:learn_flutter_aws/src/core/utils/logger.dart';
import 'package:learn_flutter_aws/src/features/user/data/models/user_model.dart';
import 'package:learn_flutter_aws/src/features/user/data/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserInitial()) {
    on<UserEvent>(
      (event, emit) => switch (event) {
        UserFetched() => _getUser(event, emit),
      },
    );
  }

  FutureOr<void> _getUser(event, emit) async {
    try {
      emit(UserLoading());

      final UserModel userModel = await _userRepository.getUser(id: event.id);

      emit(UserFetchSuccess(userModel: userModel));
    } catch (error, stackTrace) {
      logger.e('AuthBloc', error: error, stackTrace: stackTrace);

      emit(UserFuiluer());
    }
  }
}
