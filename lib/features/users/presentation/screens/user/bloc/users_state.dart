part of 'users_bloc.dart';

sealed class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

final class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class usersDataLoaded extends UsersState {
  final List<UserModelResponse> users;

  const usersDataLoaded({required this.users});
}
