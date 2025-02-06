import 'package:users/features/users/data/mappers/comments_response.dart';
import 'package:users/features/users/data/mappers/user_model_response.dart';
import 'package:users/features/users/data/mappers/user_posts_model_response.dart';

abstract class UserRepository {
  Future<List<UserModelResponse>?> getUsers();

  Future<List<Userposts>?> getUserPosts(String userId);



  Future<List<CommetsResponse>?> getCommets (String postId);
}
