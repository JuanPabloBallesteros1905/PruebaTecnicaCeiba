import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:users/core/utils/textos.dart';
import 'package:users/features/users/data/mappers/user_model_response.dart';
import 'package:users/features/users/presentation/screens/user/bloc/users_bloc.dart';
import 'package:users/features/users/presentation/widgets/index.dart';

class UsersScreen extends StatefulWidget {
  UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final UsersBloc blocUsers = UsersBloc();
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  @override
  void initState() {
    super.initState();
    blocUsers.add(GetUsers());
  }

  List<UserModelResponse> filterUsers(
      List<UserModelResponse> users, String query) {
    if (query.isEmpty) return users;

    return users.where((user) {
      final name = user.name.toLowerCase();
      final email = user.email.toLowerCase();
      final phone = user.phone.toLowerCase();
      final searchLower = query.toLowerCase();

      return name.contains(searchLower) ||
          email.contains(searchLower) ||
          phone.contains(searchLower);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Textos.mainAppBarTittle,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocProvider(
        create: (context) => blocUsers,
        child: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            if (state is UsersLoading) {
              //TODO: poner el porcentaje de carga

              return const Center(child: CircularProgressIndicator());
            }

            if (state is usersDataLoaded) {
              final filteredUsers = filterUsers(state.users, searchQuery);

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: 16,
                    children: [
                      //Input
                      TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Buscar usuarios...',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: searchQuery.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    searchController.clear();
                                    setState(() {
                                      searchQuery = '';
                                    });
                                  },
                                )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Colors.blue.shade300, width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                        ),
                      ),

                      if (filteredUsers.isEmpty)
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Text(
                                  'List is empty',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  'Sin resultados para $searchQuery',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        SizedBox(
                            width: double.infinity,
                            height: 600,
                            child: ListView.builder(
                                itemCount: filteredUsers.length,
                                itemBuilder: (context, index) {
                                  final item = filteredUsers[index];
                                  return CustomCardUser(
                                    showSeePots: true,
                                    name: item.name,
                                    phone: item.phone,
                                    email: item.email,
                                    onpress: (){
                                      Navigator.pushNamed(context, 'userDetails', arguments: {
                                        "userId" : item.id.toString(),
                                        "name" : item.name,
                                        "phone": item.phone,
                                        "email": item.email
                                      });
                                    },
                                  );
                                }))
                      /*         SizedBox(
                          width: double.infinity,
                          height: 600,
                          child:
                              ListView.builder(itemBuilder: (context, index) {
                            final item = users[index];
                            return CustomCardUser(
                              name: item.name,
                              phone: item.phone,
                              email: item.email,
                            );
                          })) */
                    ],
                  ),
                ),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
