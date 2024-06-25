part of 'list_users_bloc.dart';

sealed class ListUsersState extends Equatable {
  const ListUsersState();

  @override
  List<Object> get props => [];
}

final class ListUsersInitial extends ListUsersState {}

final class ListUsersLoading extends ListUsersState {}

final class ListUsersFetchSuccess extends ListUsersState {
  const ListUsersFetchSuccess({
    required this.userModelList,
  });

  final List<UserModel> userModelList;

  @override
  List<Object> get props => [userModelList];
}

final class ListUsersFuiluer extends ListUsersState {}
