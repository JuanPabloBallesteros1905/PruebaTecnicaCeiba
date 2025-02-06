part of 'users_details_bloc.dart';

sealed class UsersDetailsEvent extends Equatable {
  const UsersDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetusersPosts extends UsersDetailsEvent {
  final String userId;

  GetusersPosts({required this.userId});
}

class GetComments extends UsersDetailsEvent {
  final String postId;

  const GetComments({required this.postId});
}
