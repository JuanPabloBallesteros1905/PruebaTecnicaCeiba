import 'package:users/features/users/data/models/user_model_response.dart';
import 'package:users/features/users/data/models/user_posts_model_response.dart';
import 'package:users/features/users/domain/repositories/user_repositorie.dart';

import 'package:http/http.dart' as http;

class UsersNetwork extends UserRepository {
  final usersUrl = 'https://jsonplaceholder.typicode.com/users';

  @override
  Future<List<UserModelResponse>?> getUsers() async {
    try {
      final response = await http.get(Uri.parse(usersUrl));

      return userModelResponseFromJson(response.body);
    } catch (e) {
      print('error in Users network $e');
      return null;
    }
  }

  @override
  Future<List<Userposts>?>  getUserPosts(String userId) async {
    final urlUserPosts =
        'https://jsonplaceholder.typicode.com/posts?userId=$userId';

    try {
      final response = await http.get(Uri.parse(urlUserPosts));

      print('response pots ${response.body}');

      return userpostsFromJson(response.body);

    } catch (e) {
      print('error in Users network $e');
    }
  }
}
