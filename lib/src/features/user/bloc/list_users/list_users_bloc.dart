import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:learn_flutter_aws/src/core/utils/logger.dart';
import 'package:learn_flutter_aws/src/features/user/data/models/user_model.dart';
import 'package:learn_flutter_aws/src/features/user/data/repositories/user_repository.dart';

part 'list_users_event.dart';
part 'list_users_state.dart';

class ListUsersBloc extends Bloc<ListUsersEvent, ListUsersState> {
  final UserRepository _userRepository;

  ListUsersBloc(this._userRepository) : super(ListUsersInitial()) {
    on<ListUsersEvent>(
      (event, emit) => switch (event) {
        ListUsersFetched() => _listUsers(event, emit),
      },
    );
  }

  FutureOr<void> _listUsers(event, emit) async {
    try {
      emit(ListUsersLoading());

      final List<UserModel> userModelList = await _userRepository.listUsers();

      emit(ListUsersFetchSuccess(userModelList: userModelList));
    } catch (error, stackTrace) {
      logger.e('AuthBloc', error: error, stackTrace: stackTrace);

      emit(ListUsersFuiluer());
    }
  }
}
