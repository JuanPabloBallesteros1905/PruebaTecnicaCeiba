import 'package:users/features/users/data/models/user_model_response.dart';
import 'package:users/features/users/data/models/user_posts_model_response.dart';

abstract class UserRepository {
  Future<List<UserModelResponse>?> getUsers();

  Future<List<Userposts>?> getUserPosts(String userId);
}
