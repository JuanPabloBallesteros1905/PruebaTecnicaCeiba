part of 'users_details_bloc.dart';

sealed class UsersDetailsState extends Equatable {
  const UsersDetailsState();
  
  @override
  List<Object> get props => [];
}

final class UsersDetailsInitial extends UsersDetailsState {}




class PostsLoading extends UsersDetailsState {}

class PostsLoaded extends UsersDetailsState {
  final List<Userposts> posts;

  PostsLoaded({required this.posts});
}