part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserFetchSuccess extends UserState {
  const UserFetchSuccess({
    required this.userModel,
  });

  final UserModel userModel;

  @override
  List<Object> get props => [userModel];
}

final class UserFuiluer extends UserState {}
