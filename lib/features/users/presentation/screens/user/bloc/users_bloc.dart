import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users/features/users/data/models/user_model_response.dart';
import 'package:users/features/users/domain/network/users_network.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitial()) {
    final UsersNetwork usersNetwork = UsersNetwork();

    on<GetUsers>((event, emit) async {


      emit(UsersLoading());
      try {


      

       List<UserModelResponse>? users = await usersNetwork.getUsers();

       print('users $users');

        if (users != null) {
          emit(usersDataLoaded(users: users ));

          return;
        }
        


  

        
      } catch (e) {
        print('error in Users bloc $e');
      }
    });
  }
}
