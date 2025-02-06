import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users/features/users/data/datasource/local_database.dart';
import 'package:users/features/users/data/mappers/user_model_response.dart';
import 'package:users/features/users/data/models/users_model.dart';
import 'package:users/features/users/domain/network/users_network.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersNetwork _usersNetwork;
  final LocalDatabase _localDb;

  UsersBloc()
      : _usersNetwork = UsersNetwork(),
        _localDb = LocalDatabase(),
        super(UsersInitial()) {
    on<GetUsers>(_getUsers);
  }

  Future<void> _getUsers(GetUsers event, Emitter<UsersState> emit) async {
    try {
      emit(UsersLoading());

      await _localDb.database;

      final localUsers = await _localDb.getDataUsers();

      if (localUsers?.isEmpty ?? true) {
        final networkUsers = await _usersNetwork.getUsers();

        if (networkUsers != null) {
          for (var user in networkUsers) {
            await _localDb.insertUserData(
              UsersModel(
                id: user.id.toString(),
                name: user.name,
                email: user.email,
                phone: user.phone,
              ),
            );
          }
        }
      }

      final updatedUsers = await _localDb.getDataUsers();

      if (updatedUsers != null) {
        final usersList = updatedUsers
            .map((user) => UserModelResponse.fromJson(user))
            .toList();

        emit(UsersDataLoaded(users: usersList));
      } else {
        emit(UsersError(message: 'No se pudieron cargar los usuarios'));
      }
    } catch (e) {
      emit(UsersError(message: 'Error al cargar usuarios: ${e.toString()}'));
    }
  }
}
