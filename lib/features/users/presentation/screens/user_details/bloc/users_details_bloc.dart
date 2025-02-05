import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users/features/users/data/models/user_posts_model_response.dart';
import 'package:users/features/users/domain/network/users_network.dart';

part 'users_details_event.dart';
part 'users_details_state.dart';

class UsersDetailsBloc extends Bloc<UsersDetailsEvent, UsersDetailsState> {
  UsersDetailsBloc() : super(UsersDetailsInitial()) {


    final UsersNetwork  usersNetwork = UsersNetwork();



    on<GetusersPosts>((event, emit)  async {
      

      emit(PostsLoading());

      try {

       List<Userposts>? posts = await usersNetwork.getUserPosts(event.userId);


       if (posts != null) {
         emit(PostsLoaded(posts: posts));
         
       }

        

        
      } catch (e) {
        print('error in Users posts bloc $e');
        
      }

    });
  }
}
