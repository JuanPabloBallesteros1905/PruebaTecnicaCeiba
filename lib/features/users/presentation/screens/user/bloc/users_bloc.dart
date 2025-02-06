import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users/features/users/data/datasource/local_database.dart';
import 'package:users/features/users/data/mappers/user_model_response.dart';
import 'package:users/features/users/data/models/users_model.dart';
import 'package:users/features/users/domain/network/users_network.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitial()) {
    final UsersNetwork usersNetwork = UsersNetwork();
    final LocalDatabase localDb = LocalDatabase();

    on<GetUsers>((event, emit) async {
      emit(UsersLoading());

      //*Crear base de datos
      await localDb.database;

      List<Map<String, Object?>>? users = await localDb.getDataUsers();

      List<UserModelResponse> usersData3 =
          users!.map((user) => UserModelResponse.fromJson(user)).toList();

      if (users!.isEmpty) {
        List<UserModelResponse>? usersData = await usersNetwork.getUsers();
        // TODO: hacer la peticion y llenar la base de datos

        for (var i = 0; i < usersData!.length; i++) {
          UsersModel user = UsersModel(
            id: usersData[i].id.toString(),
            name: usersData[i].name,
            email: usersData[i].email,
            phone: usersData[i].phone,
          );

          await localDb.insertUserData(user);
        }
        List<Map<String, Object?>>? usersData2 = await localDb.getDataUsers();

        List<UserModelResponse> usersData3 = usersData2!
            .map((user) => UserModelResponse.fromJson(user))
            .toList();

        print('GUARDNANOD EN LAB BASE DE DATOS');

        emit(usersDataLoaded(users: usersData3!));
      }
      

      print('Mostrando desde la base de datps ');
      emit(usersDataLoaded(users: usersData3!));
    });
  }
}
