part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

final class UserFetched extends UserEvent {
  const UserFetched({
    required this.id,
  });

  final String id;

  @override
  List<Object> get props => [id];
}
